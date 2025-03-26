lfs() {
  sudo yazi
}

copydir() {
  # Check if wl-copy is installed
  if command -v wl-copy &> /dev/null; then
    print -n $PWD | wl-copy
  else
    echo "wl-copy is not installed. Cannot copy current directory."
  fi
}

copylastcommand() {
  # Check if wl-copy is installed
  if command -v wl-copy &> /dev/null; then
    fc -ln -1 | tr -d '\n' | wl-copy
  else
    echo "wl-copy is not installed. Cannot copy last command."
  fi
}

copybuffer() {
  # You've already implemented the check here!
  if command -v wl-copy &> /dev/null; then
    echo "$BUFFER" | wl-copy
  else
    echo "Error! Couldn't copy current line. wl-copy not present"
  fi
}

count_files() {
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

speedtest_curl() {
  curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -
}

s() {
  search_term="$1"

  SELECTED_FILE=$(
    fd . $HOME --type f --hidden --follow --color=always \
      --exclude ".rustup" \
      --exclude "node_modules" \
      --exclude ".cargo" \
      --exclude ".continue" \
      --exclude ".cargo" \
      --exclude "go/pkg/mod" \
      --exclude ".npm" \
      --exclude ".cache" |
      fzf \
        --query="$search_term" \
        --exact \
        --extended \
        --preview="bat --style=numbers --color=always --line-range :500 {}" \
        --preview-window="right:50%" \
        --ansi
  )

  if [ -n "$SELECTED_FILE" ]; then
    file_extension="${SELECTED_FILE##*.}"

    case "$file_extension" in
      pdf) evince "$SELECTED_FILE" ;;
      jpg | jpeg | png | gif | bmp | webp) (command -v loupe &> /dev/null && loupe "$SELECTED_FILE") || (command -v org.kde.gwenview &> /dev/null && org.kde.gwenview "$SELECTED_FILE") ;;
      mp4 | mkv | avi | webm) mpv "$SELECTED_FILE" ;;
      txt | py | rs | go | md) (command -v nvim &> /dev/null && nvim "$SELECTED_FILE") || vim "$SELECTED_FILE" ;;
      *) (command -v nvim &> /dev/null && nvim "$SELECTED_FILE") || vim "$SELECTED_FILE" ;;
    esac

    # Copy file path to clipboard if wl-copy is available
    command -v wl-copy &> /dev/null && echo "$SELECTED_FILE" | wl-copy

    # Print the file path
    echo "$SELECTED_FILE"
  fi
}

f() {
  search_term="$1"

  SELECTED_FILE=$(
    fd --type f --hidden --follow --color=always \
      --exclude ".local" \
      --exclude ".rustup" \
      --exclude "node_modules" \
      --exclude ".cargo" \
      --exclude ".continue" \
      --exclude ".cargo" \
      --exclude ".mozilla" \
      --exclude "go/pkg/mod" \
      --exclude "Code/User" \
      --exclude ".git" \
      --exclude ".npm" \
      --exclude ".cache" |
      fzf \
        --query="$search_term" \
        --exact \
        --extended \
        --preview="bat --style=numbers --color=always --line-range :500 {}" \
        --preview-window="right:50%" \
        --ansi
  )

  if [ -n "$SELECTED_FILE" ]; then
    file_extension="${SELECTED_FILE##*.}"

    case "$file_extension" in
      pdf) evince "$SELECTED_FILE" ;;
      jpg | jpeg | png | gif | bmp | webp) (command -v loupe &> /dev/null && loupe "$SELECTED_FILE") || (command -v org.kde.gwenview &> /dev/null && org.kde.gwenview "$SELECTED_FILE") ;;
      mp4 | mkv | avi | webm) mpv "$SELECTED_FILE" ;;
      txt | py | rs | go | md) (command -v nvim &> /dev/null && nvim "$SELECTED_FILE") || vim "$SELECTED_FILE" ;;
      *) (command -v nvim &> /dev/null && nvim "$SELECTED_FILE") || vim "$SELECTED_FILE" ;;
    esac

    # Copy file path to clipboard if wl-copy is available
    command -v wl-copy &> /dev/null && echo "$SELECTED_FILE" | wl-copy

    # Print the file path
    echo "$SELECTED_FILE"
  fi
}

# cd into dir
ff() {
  local selected_file
  selected_file=$(
    fd --type f --hidden --follow --color=always \
      --exclude ".local" \
      --exclude ".rustup" \
      --exclude "node_modules" \
      --exclude ".cargo" \
      --exclude ".continue" \
      --exclude ".cargo" \
      --exclude ".mozilla" \
      --exclude "go/pkg/mod" \
      --exclude "Code/User" \
      --exclude ".git" \
      --exclude ".npm" \
      --exclude ".cache" |
      fzf \
        --query="$search_term" \
        --exact \
        --extended \
        --preview="bat --style=numbers --color=always --line-range :500 {}" \
        --preview-window="right:50%" \
        --ansi
  )
  if [[ -n $selected_file ]]; then
    local parent_dir
    parent_dir=$(dirname "$selected_file")
    cd "$parent_dir" || echo "Failed to change directory"
  else
    echo "No file selected"
  fi
}

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
  rg -v "$var_to_remove" ~/.zsh_history > "$temp_file"

  # Overwrite the original history file with the cleaned version
  mv "$temp_file" ~/.zsh_history

  echo "Deleted $(echo "$found_lines" | wc -l) lines containing '$var_to_remove'."

  # Reload the shell
  exec zsh
}

# fh() {
#   selected_command=$(history -E 1 | sort -k1,1nr | fzf | awk '{$1=""; $2=""; $3=""; print $0}' | sed 's/^[ \t]*//')
#
#   # Check if wl-copy is installed
#   if command -v wl-copy &> /dev/null; then
#     echo "$selected_command" | wl-copy
#   else
#     echo "wl-copy is not installed. Cannot copy to clipboard."
#   fi
# }

finh() {
  cat /var/log/pacman.log | grep -E "\[ALPM\] (installed|removed|upgraded|upgraded|downgraded)" | awk '{print $1, $2, $3, $4, $5, $6}' | sort -r | fzf
}

# search all installed packages
fin() {
  pacman -Qq | fzf --preview='pacman -Qi {}'
}

in() {
  pacman -Slq | fzf -q "$1" -m --preview 'pacman -Si {1}' | xargs -ro pacman -S
}

# launch-waybar(){
#     CONFIG_FILES="$DOTFILES/waybar/config.jsonc $DOTFILES/waybar/style.css "
#
#     #$DOTFILES/waybar/config2.jsonc
#
#     trap "killall waybar" EXIT
#
#     while true; do
#         waybar &
#         inotifywait -e create,modify $CONFIG_FILES
#         killall waybar
#     done
# }
#

# Function to create or open a note in $HOME/Notes/docs directory
note() {
  local note_path="$HOME/notes/docs/$1.md"
  if [[ -f "$note_path" ]]; then
    # If the note exists, open it in neovim
    nvim "$note_path"
  else
    # Create a new note and open it in neovim
    mkdir -p "$(dirname "$note_path")" # Ensure the directory exists

    # Get the current date in YYYY-MM-DD format
    local current_date
    current_date=$(date +"%Y-%m-%d")

    # Predefine the template
    cat << EOF > "$note_path"
---
title: "$1"
date: $current_date
tags: []
---

EOF

    # Open in neovim and switch to insert mode at the last line
    # nvim +"normal G$" +"startinsert" "$note_path"
    # nvim +"normal G$o" +"startinsert" "$note_path"
    nvim +"normal Go" +"startinsert" "$note_path"

  fi
}

# Function to enable autocompletion for the `note` command
_note_autocomplete() {
  local cur_word="${1}" # Current word typed
  local notes_dir="$HOME/notes/docs"

  # List all files and directories in the notes directory
  local suggestions=($(find "$notes_dir" -type d -mindepth 1 -maxdepth 2 | sed "s|$notes_dir/||"))

  # Add files without `.md` extension to the suggestions
  suggestions+=($(find "$notes_dir" -type f -name "*.md" | sed "s|$notes_dir/||" | sed "s|\.md$||"))

  # Provide suggestions for autocomplete
  compadd "${suggestions[@]}"
}

# Bind autocompletion to the note function
compdef _note_autocomplete note
