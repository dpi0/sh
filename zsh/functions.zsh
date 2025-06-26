# Ask to create a directory if not present, else just cd into it
sd() {
  if [ ! -d "$1" ]; then
    echo -n "Directory '$1' does not exist. Create it? (Y/n): "
    read confirm
    confirm=${confirm:-y} # Default to 'y' if empty
    if [[ $confirm == [Yy]* ]]; then
      mkdir -p -- "$1"
      echo "Directory created."
    else
      echo "Operation canceled."
      return 1
    fi
  fi
  builtin cd -- "$1"
}

# Count the total number of files in $PWD
file_count() {
  local dir="${1:-$(pwd)}"
  local group=false

  if [ "$1" = "-g" ] || [ "$1" = "--group" ]; then
    group=true
    dir="${2:-$(pwd)}"
  fi

  if $group; then
    fd -H -t f . "$dir" | awk -F. '{ext = $NF; if (ext != $0) {count[ext]++}} END {for (ext in count) print ext, count[ext]}'
  else
    fd -H . "$dir" | wc -l
  fi
}

# Remove a sensitive variable from shell history
remove_variable_from_history() {
  local var_to_remove="$1"
  local temp_file=$(mktemp)

  # Use ripgrep to find lines containing the variable and list them
  local found_lines=$(rg --color=always "$var_to_remove" ~/.zsh_history)

  if [[ -z "$found_lines" ]]; then
    echo "No lines containing '$var_to_remove' found in ~/.zsh_history."
    return
  fi

  # Display the found lines
  echo "The following lines will be deleted:"
  echo "$found_lines"

  # Use ripgrep to exclude lines containing the variable and write to the temporary file
  rg -v "$var_to_remove" ~/.zsh_history >"$temp_file"

  # Overwrite the original history file with the cleaned version
  mv "$temp_file" ~/.zsh_history

  echo "Deleted $(echo "$found_lines" | wc -l) lines containing '$var_to_remove'."

  # Reload the shell
  exec zsh
}

# Pacman log - Fuzzy Find
plf() {
  cat /var/log/pacman.log | grep -E "\[ALPM\] (installed|removed|upgraded|upgraded|downgraded)" | awk '{print $1, $2, $3, $4, $5, $6}' | sort -r | fzf
}

# All currently installed packages - Fuzzy Find
inf() {
  pacman -Qq | fzf --preview='pacman -Qi {}'
}

# Pacman main repo - Fuzzy Find
in() {
  pacman -Slq | fzf -q "$1" -m --preview 'pacman -Si {1}' | xargs -ro pacman -S
}

# Restart compose project
dcr() {
  if [ -z "$1" ]; then
    echo "Usage: dcr <service_or_project_name>. Runs docker compose down; docker compose up -d"
    return 1
  fi
  NAME="$1"
  docker compose down "$NAME"
  docker compose up -d "$NAME"
}

# Alias - Fuzzy Find
af() {
  CMD=$(
    (
      (alias)
      (functions | grep "()" | cut -d ' ' -f1 | grep -v "^_")
    ) | fzf --preview='' --preview-window=hidden | cut -d '=' -f1
  )

  eval $CMD
}

# https://github.com/beauwilliams/awesome-fzf

# cd - Fuzzy Find
# cdf() {
#   local dir
#   dir=$(fd --type d --hidden --exclude '.*' . "${1:-.}" 2> /dev/null | fzf +m) &&
#     cd "$dir"
#   ls
# }

# Environment Variables
envf() {
  local out
  out=$(env | awk -F= '{printf "\033[1;36m%s\033[0m=\033[1;32m%s\033[0m\n", $1, $2}' | fzf --ansi)
  echo "$(echo "$out" | sed 's/.*=\x1b\[1;32m//' | sed 's/\x1b\[0m.*//')"
}

# Kill Processes
killf() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m --preview-window=hidden | awk '{print $2}')

  if [ "x$pid" != "x" ]; then
    echo $pid | xargs kill -${1:-9}
  fi
}

# Git Status - Fuzzy Find
# gst() {
#     git rev-parse --git-dir > /dev/null 2>&1 || { echo "You are not in a git repository" && return }
#     local selected
#     selected=$(git -c color.status=always status --short |
#         fzf --height 50% "$@" --border -m --ansi --nth 2..,.. \
#         --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
#         cut -c4- | sed 's/.* -> //')
#             if [[ $selected ]]; then
#                 for prog in $(echo $selected);
#                 do $EDITOR $prog; done;
#             fi
# }

# https://github.com/happycod3r/fzf-tools#documentation

# Fuzzy search the man pages
manf() {
  local selected_command
  selected_command=$(
    man -k . |
      awk '{print $1}' |
      sort |
      uniq |
      fzf --multi --cycle \
        --preview='echo {}'
  )
  if [[ -n "$selected_command" ]]; then
    man "$selected_command" |
      fzf --multi --cycle --tac --no-sort \
        --preview='echo {}' \
        --layout='reverse-list'
  fi
}

# Allows searching for and executing a command from your command history interactively using fzf.
hf() {
  local cmd
  cmd=$(history -E 1 | tac | fzf --preview='' --preview-window=hidden | awk '{$1=""; $2=""; $3=""; sub(/^ +/, ""); print}')
  [[ -n "$cmd" ]] && {
    command -v wl-copy &>/dev/null && printf '%s' "$cmd" | wl-copy
    printf '%s\n' "$cmd"
  }
}

# History fuzzy find and Ctrl+Y to copy as well
# only problem is hitting enter doesn't produce stdout of the command
# so going with CTRL+R for fzf-tab for now, otherwise this is nice
# fzf-history-widget() {
#   local selected
#   selected=$(builtin history -E 1 | fzf \
#     --layout=reverse \
#     --preview='echo {}' \
#     --preview-window=up:3:hidden:wrap \
#     --bind='ctrl-/:toggle-preview' \
#     --bind='ctrl-y:execute-silent(echo -n {4..} | wl-copy)+abort' \
#     --color=header:italic \
#     --header='Press CTRL-Y to copy command into clipboard' \
#     --bind='ctrl-u:preview-page-up,ctrl-d:preview-page-down,shift-up:preview-top,shift-down:preview-bottom')
#
#   if [[ -n $selected ]]; then
#     BUFFER="${selected#* }"
#     CURSOR=$#BUFFER
#     zle reset-prompt
#   fi
# }

# Fuzzy find on all files recursively, and jump to the directory of the selected file
jump_to_dir_of_file() {
  local file
  file=$(
    fzf \
      --walker-skip .git,node_modules,target,.cache \
      --preview 'bat -n --color=always {}'
  ) || return
  echo "$file"
  cd "$(dirname "$file")" || return
}

# Same as above, BUT show a tree for the respective file's parent directory
jump_to_dir_of_file_tree() {
  local file
  file=$(
    fzf \
      --walker-skip .git,node_modules,target,.cache \
      --preview 'tree -C -L 2 $(dirname {}) | head -100; echo ""; echo "Selected: {}"; echo ""; ls -la $(dirname {})/{} 2>/dev/null || echo "Directory"'
  ) || return
  echo "$file"
  cd "$(dirname "$file")" || return
}

# Fuzzy find directories only and change to selected directory
# Shows tree view of the hovered directory in preview window
# As i am explicitly passing fd --type d into fzf (have to!), this overrides FZF_DEFAULT_OPTS and FZF_DEFAULT_COMMAND
# so i have to fd commands manually here (not in other functions)
# Shared exclude flags for fd
FD_EXCLUDES=(
  --exclude node-modules
  --exclude go/pkg/mod
  --exclude .local/share
  --exclude .local/state
  --exclude .vscode
  --exclude .config/Code
  --exclude .Trash-1000
  --exclude .git
  --exclude .cargo
  --exclude .rustup
  --exclude .cache
  --exclude .mozilla
  --exclude .npm
)

fzf_cd() {
  local dir
  dir=$(
    fd --type d . --color=always "${FD_EXCLUDES[@]}" |
      fzf --exact --preview '
      echo "📁 Directory: {}"; echo "";
      echo "📊 Stats:"; echo "   $(fd --type f . {} | wc -l) files, $(du -sh {} | cut -f1) size"; echo "";
      echo "🌳 Tree:"; tree -a -C -L 3 {} | head -100'
  ) || return
  cd "$dir" || return
}

_jump_to_file_core() {
  local search_term="$1"
  local search_path="$2"
  local selected_file

  selected_file=$(fd --type f . "$search_path" --color=always "${FD_EXCLUDES[@]}" |
    fzf --query="$search_term")

  if [ -n "$selected_file" ]; then
    local file_extension="${selected_file##*.}"

    case "$file_extension" in
    pdf)
      evince "$selected_file"
      ;;
    jpg | jpeg | png | gif | bmp | webp)
      (command -v loupe &>/dev/null && loupe "$selected_file") ||
        (command -v org.kde.gwenview &>/dev/null && org.kde.gwenview "$selected_file")
      ;;
    mp4 | mkv | avi | webm)
      mpv "$selected_file"
      ;;
    txt | py | rs | go | md)
      (command -v nvim &>/dev/null && nvim "$selected_file") || vim "$selected_file"
      ;;
    *)
      (command -v nvim &>/dev/null && nvim "$selected_file") || vim "$selected_file"
      ;;
    esac

    command -v wl-copy &>/dev/null && echo "$selected_file" | wl-copy
    echo "$selected_file"
  fi
}

# Search from current directory
jump_to_file() {
  _jump_to_file_core "$1" "."
}

# Search from $HOME
jump_to_file_from_home() {
  _jump_to_file_core "$1" "$HOME"
}

# Grep Fuzzy Search with a forked rga-fzf to open files in nvim only
rga-my-fzf() {
  RG_PREFIX="rga --files-with-matches"
  local selected_file
  selected_file="$(
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
      fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
      --phony -q "$1" \
      --bind "change:reload:$RG_PREFIX {q}" \
      --preview-window="70%:wrap"
  )"

  if [ -n "$selected_file" ]; then
    if command -v nvim &>/dev/null; then
      nvim "$selected_file"
    else
      echo "nvim not found" >&2
      exit 1
    fi

    command -v wl-copy &>/dev/null && echo "$selected_file" | wl-copy
    echo "$selected_file"
  fi
}

# Zoxide with a tree preview pane using fzf!
z_fzf() {
  local dir
  dir=$(
    zoxide query -ls | awk '{$1=""; sub(/^ /, ""); print}' |
      fzf --exact \
        --preview '
          dir=$(echo {} | xargs realpath 2>/dev/null)
          [[ -z "$dir" || ! -d "$dir" ]] && exit

          echo "📊 Stats:"
          file_count=$(fd --type f . "$dir" 2>/dev/null | wc -l)
          dir_size=$(du -sh "$dir" 2>/dev/null | cut -f1)
          printf "   %s files, %s total size\n" "$file_count" "$dir_size"
          echo ""

          echo "🔧 Git status:"
          if git -C "$dir" rev-parse --is-inside-work-tree &>/dev/null; then
            git -C "$dir" status --short -b | head -5 | sed "s/^/   /"
          else
            echo "   Not a git repository."
          fi
          echo ""

          echo "🌳 Tree (depth 2):"
          tree -a -C -L 2 "$dir" 2>/dev/null | head -100
        ' \
        --preview-window=right:30%
  ) || return

  cd "$dir" || return
}

v() {
  if [ -z "$1" ]; then
    echo "Usage: b <path/to/file>"
    return 1
  fi

  local file_path="$1"
  local dir_path
  dir_path=$(dirname "$file_path")

  # Check if directory already exists
  if [ ! -d "$dir_path" ]; then
    echo -n "Do you want to create $PWD/$dir_path (y/N)? "
    read -r response

    if [[ "$response" != "" && ! "$response" =~ ^[Yy]$ ]]; then
      echo "Cancelled."
      return 0
    fi

    mkdir -p "$dir_path" || {
      echo "Failed to create directory."
      return 1
    }
  fi

  # Choose editor
  local editor_cmd
  if command -v nvim &>/dev/null; then
    editor_cmd="nvim"
  elif command -v vim &>/dev/null; then
    editor_cmd="vim"
  else
    echo "Neither nvim nor vim found."
    return 1
  fi

  "$editor_cmd" "$file_path"
}

list-ips-kvm() {
  for domain in $(virsh list --name --state-running); do
    echo "$domain:"
    virsh domifaddr "$domain"
  done
}

clone-vm() {
  if [ $# -lt 2 ]; then
    echo "Usage: clone-vm <original-vm-name> <new-vm-name>"
    echo "Description:"
    echo "  Clones an existing VM using virt-clone."
    echo ""
    echo "Arguments:"
    echo "  <original-vm-name>  Name of the existing virtual machine to clone."
    echo "  <new-vm-name>       Desired name for the cloned virtual machine."
    return 1
  fi

  exisiting_vm="$1"
  new_vm="$2"

  if virsh dominfo "$new_vm" &>/dev/null; then
    echo "VM '$new_vm' already exists. Exiting..."
    virsh list --all
    return 1
  fi

  virt-clone \
    --original "$exisiting_vm" \
    --name "$new_vm" \
    --auto-clone

  list-ips-kvm
}

shutdown-all-vm() {
  for vm in $(virsh list --name); do
    virsh shutdown "$vm"
  done
  virsh list --all
}

start-all-vm() {
  for vm in $(virsh list --all --name); do
    virsh start "$vm"
  done
}

remove-vm() {
  vm="$1"

  if ! virsh dominfo "$vm" &>/dev/null; then
    echo "VM '$vm' does not exist."
    virsh list --all
    return 1
  fi

  printf "Are you sure you want to completely remove VM '%s'? (y/n): " "$vm"
  read confirm

  if [[ "$confirm" == [Yy] ]]; then
    vm_state=$(virsh domstate "$vm" 2>/dev/null)

    if [[ "$vm_state" != "shut off" ]]; then
      echo "Shutting down $vm..."
      virsh shutdown "$vm"
      echo "Waiting for $vm to shut down..."
      for i in {1..30}; do
        sleep 1
        [[ "$(virsh domstate "$vm")" == "shut off" ]] && break
      done
    else
      echo "$vm is already shut off."
    fi

    echo "Removing $vm..."
    virsh undefine --nvram --remove-all-storage "$vm"
    virsh list --all
  else
    echo "Aborted."
  fi
}

start-vm() {
  if [ "$#" -eq 0 ]; then
    echo "Usage: start-vm VM_NAME [VM_NAME ...]"
    echo "Starts one or more virtual machines using virsh."
    echo "Example: start-vm jumpbox master worker0"
    return 1
  fi
  for vm in "$@"; do
    echo -n "Starting VM: $vm... "
    if virsh start "$vm" &>/dev/null; then
      echo "OK"
    else
      echo "FAILED"
    fi
  done
}

download-video() {
  yt-dlp --ignore-config --simulate "$1" >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "Invalid or inaccessible URL: $1"
    exit 1
  fi

  # The yt-dlp command as a variable for easy printing
  cmd="yt-dlp \
    --newline \
    -o \"$HOME/Downloads/Videos/%(title)s.%(ext)s\" \
    --embed-subs \
    --write-sub \
    --sub-lang en \
    --embed-thumbnail \
    --merge-output-format mp4 \
    --format bestvideo+bestaudio \
    --ignore-config \
    --add-metadata \
    \"$1\""

  echo "🔹 Running: $cmd"

  yt-dlp \
    --newline \
    -o "$HOME/Downloads/Videos/%(title)s.%(ext)s" \
    --embed-subs \
    --write-sub \
    --sub-lang en \
    --embed-thumbnail \
    --merge-output-format mp4 \
    --format bestvideo+bestaudio \
    --ignore-config \
    --add-metadata \
    "$1"
}
