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

dcr() {
  if [ -z "$1" ]; then
    echo "Usage: dcr <service_or_project_name>. Runs docker compose down; docker compose up -d"
    return 1
  fi
  NAME="$1"
  docker compose down "$NAME"
  docker compose up -d "$NAME"
}

af() {
  CMD=$(
    (
      (alias)
      (functions | grep "()" | cut -d ' ' -f1 | grep -v "^_")
    ) | fzf | cut -d '=' -f1
  )

  eval $CMD
}

# https://github.com/beauwilliams/awesome-fzf

cdf() {
  local dir
  dir=$(fd --type d --hidden --exclude '.*' . "${1:-.}" 2> /dev/null | fzf +m) &&
    cd "$dir"
  ls
}

envf() {
  local out
  out=$(env | awk -F= '{printf "\033[1;36m%s\033[0m=\033[1;32m%s\033[0m\n", $1, $2}' | fzf --ansi)
  echo "$(echo "$out" | sed 's/.*=\x1b\[1;32m//' | sed 's/\x1b\[0m.*//')"
}

killf() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]; then
    echo $pid | xargs kill -${1:-9}
  fi
}

gst() {
    git rev-parse --git-dir > /dev/null 2>&1 || { echo "You are not in a git repository" && return }
    local selected
    selected=$(git -c color.status=always status --short |
        fzf --height 50% "$@" --border -m --ansi --nth 2..,.. \
        --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
        cut -c4- | sed 's/.* -> //')
            if [[ $selected ]]; then
                for prog in $(echo $selected);
                do; $EDITOR $prog; done;
            fi
    }
