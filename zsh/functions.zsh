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

# All currently installed packages - Fuzzy Find
inf() {
  pacman -Qq | fzf --preview='pacman -Qi {}'
}

# Pacman main repo - Fuzzy Find
in() {
  pacman -Slq | fzf -q "$1" -m --preview 'pacman -Si {1}' | xargs -ro pacman -S
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

# Environment Variables
envf() {
  local out
  out=$(env | awk -F= '{printf "\033[1;36m%s\033[0m=\033[1;32m%s\033[0m\n", $1, $2}' | fzf --ansi)
  echo "$(echo "$out" | sed 's/.*=\x1b\[1;32m//' | sed 's/\x1b\[0m.*//')"
}

# Fuzzy find directories only and change to selected directory
# Shows tree view of the hovered directory in preview window
# As i am explicitly passing fd --type d into fzf (have to!), this overrides FZF_DEFAULT_OPTS and FZF_DEFAULT_COMMAND
# so i have to fd commands manually here (not in other functions)
# Shared exclude flags for fd
FD_EXCLUDES=(
  --exclude node-modules
  --exclude go/pkg/mod
  --exclude Android
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
  --exclude .bun
  --exclude .terrascan
  --exclude .bundle
  --exclude .gradle
  --exclude .pub-cache
  --exclude .config/libreoffice/
  --exclude .flutter-devtools
  --exclude .claude
  --exclude .dart-tool
  --exclude .dotnet
  --exclude .opencode
  --exclude .kube
  --exclude .dartServer
  --exclude .keychain
  --exclude .java
  --exclude .password-store
  --exclude .android
  --exclude .gemini
  --exclude .vagrant.d
  --exclude .config
  --exclude .zen
  --exclude .tmux
  --exclude .ansible
  --exclude .docker
  --exclude .gnupg
  --exclude .logseq
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

# Zoxide + fzf!
jump_to_dir() {
  local dir
  dir=$(
    zoxide query --list |
      fzf --preview-window=hidden
  ) || return

  cd "$dir" || return
}

list-ips-kvm() {
  for domain in $(virsh list --name --state-running); do
    echo "$domain:"
    virsh domifaddr "$domain" --source arp
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

txr() {
  if [ $# -lt 1 ]; then
    echo "Tmux command runner in the bg. \nUsage: txr \"command\" [session-name] (optional) \nExample:\n  txr 'gh markdown-preview ~/projects/kubernetes/from-scratch-kubeadm/README.md' readme-preview"
    return 1
  fi

  local cmd="$1"
  local session="$2"

  if [ -n "$session" ]; then
    echo "Running: tmux new-session -d -s '$session' '$cmd'"
    tmux new-session -d -s "$session" "$cmd"
  else
    tmux new-session -d "$cmd"
  fi

  echo "Running: 'tmux ls'"
  tmux ls
}

# Fuzzy find from the list of running tmux sessions, on enter hit - attach to that session
txa() {
  local session
  session=$(tmux ls 2>/dev/null |
    fzf --preview '
            session_name=$(echo {} | cut -d: -f1)
            tmux list-windows -t "$session_name" -F "▶️ W#{window_index}: #{window_name} #{window_flags}" 2>/dev/null | \
            while IFS= read -r win; do
                win_idx=$(echo "$win" | grep -oE "[0-9]+")
                echo "$win"
                tmux list-panes -t "$session_name:$win_idx" \
                    -F "    └─ 🟫 P#{pane_index}: #{pane_current_command} [#{pane_width}x#{pane_height}] #{pane_current_path} PID=#{pane_pid} #{?pane_active,★,}" 2>/dev/null
            done
        ' --preview-window=down:wrap)

  [ -n "$session" ] && tmux attach -t "$(echo "$session" | cut -d: -f1)"
}

trashe() {
  trash list |
    fzf --multi --preview "" --preview-window=hidden |
    awk '{print $NF}' |
    xargs trash empty --match=exact --force
}

trashr() {
  trash list |
    fzf --multi --preview "" --preview-window=hidden |
    awk '{print $NF}' |
    xargs trash restore --match=exact --force
}

copydir() {
  if command -v wl-copy &>/dev/null; then
    print -n $PWD | wl-copy
  else
    echo "wl-copy is not installed. Cannot copy current directory."
  fi
}

copylastcommand() {
  if command -v wl-copy &>/dev/null; then
    fc -ln -1 | tr -d '\n' | wl-copy
  else
    echo "wl-copy is not installed. Cannot copy last command."
  fi
}

copybuffer() {
  if command -v wl-copy &>/dev/null; then
    echo "$BUFFER" | wl-copy
  else
    echo "Error! Couldn't copy current line. wl-copy not present"
  fi
}

go_forward_in_words() {
  local WORDCHARS=${WORDCHARS//[-\/,.:;_=]/}
  zle forward-word
}

go_back_in_words() {
  local WORDCHARS=${WORDCHARS//[-\/,.:;_=]/}
  zle backward-word
}

delete_word() {
  local WORDCHARS=${WORDCHARS//[-\/,.:;_=]/}
  zle backward-delete-word
}

zvm_vi_yank() {
  zvm_yank
  printf %s "${CUTBUFFER}" | wl-copy -n
  zvm_exit_visual_mode
}

ditag() {
  local img="$1"

  # Validate arguments
  if [ $# -ne 1 ]; then
    echo "Usage: ditag IMAGE_NAME"
    echo "Example: ditag nginx"
    return 1
  fi

  # Check dependency
  if ! command -v regctl &>/dev/null; then
    echo "'regctl' not installed."
    return 1
  fi

  echo "Running: regctl tag ls '$img' | sort -V -r | bat"
  regctl tag ls "$img" | sort -V -r | bat
}

what() {
  if [ $# -ne 1 ]; then
    echo "Usage: what <tool>"
    echo "Example: what scp"
    return 1
  fi

  local cmd="$1"
  echo "Running: curl https://cheat.sh/$cmd"
  curl "https://cheat.sh/$cmd"
}

batf() {
  # Dependency check
  if ! command -v bat &>/dev/null || ! command -v tail &>/dev/null; then
    echo "ERROR: 'bat' or 'tail' not installed."
    return 1
  fi

  # Argument check
  if [ $# -ne 1 ]; then
    echo "Usage: batf FILE"
    echo "Example: batf /var/log/syslog"
    return 1
  fi

  local file="$1"
  if [[ ! -f "$file" ]]; then
    echo "ERROR: File '$file' does not exist."
    return 1
  fi

  local ext="${file##*.}"
  tail -f "$file" | bat -l "$ext" --paging=never
}
