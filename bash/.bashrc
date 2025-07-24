PS1='\[\e[38;5;39m\]\u\[\e[0m\]@\[\e[38;5;135m\]\h\[\e[0m\] in \[\e[38;5;220;1m\]\w\[\e[0m\] at \[\e[38;5;154m\]\t\[\e[0m\] \\$ '

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias l='ls -lah --color=auto'
alias ls='ls -lah --color=auto'
alias md='mkdir -p'
alias c='clear'
alias lf="yazi"
alias lz="lazygit"
alias slf="sudo -E yazi"
alias h="history -E 1"
alias re="source ~/.bashrc && exec bash"
alias dx='dotenvx'
alias fz="fzf --preview-window=hidden"
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch --all'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcl='git clone'
alias gd='git diff'
alias gf='git fetch'
alias gfo='git fetch origin'
alias gm='git merge'
alias gma='git merge --abort'
alias gp='git push'
alias gr='git remote'
alias grv='git remote --verbose'
alias gra='git remote add'
alias d="docker"
alias di="docker image"
alias dpsa="docker ps -a --format 'table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.Status}}'"
alias wdpsa='watch -n 1 "docker ps -a --format \"table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.Status}}\""'
alias dst="docker stats"
alias de="docker exec"
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dr="docker run"
alias dn="docker network"
alias dnl="docker network ls"
alias dv="docker volume"
alias dvl="docker volume ls"
alias rm='rm -iv'
alias cp='cp -i'
alias mv='mv -i'

if command -v rsync &>/dev/null; then
  alias cpp='rsync --archive --verbose --human-readable --progress --itemize-changes --stats'
  alias mvv='rsync -avh --remove-source-files --progress --itemize-changes --stats'
fi

if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend
shopt -s cmdhist

sysinfo() {
  echo "System Information:"
  echo "=================="
  echo "Hostname: $(hostname)"
  echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
  echo "Load: $(cat /proc/loadavg | cut -d' ' -f1-3)"
  echo "Memory: $(free -h | grep Mem | awk '{print $3 "/" $2}')"
  echo "Disk: $(df -h / | tail -1 | awk '{print $3 "/" $2 " (" $5 " used)"}')"
}

serverstatus() {
  echo "Quick Server Status Check:"
  echo "========================="
  echo "Load Average: $(cat /proc/loadavg | cut -d' ' -f1-3)"
  echo "Memory Usage: $(free | grep Mem | awk '{printf("%.2f%%\n", $3/$2 * 100.0)}')"
  echo "Disk Usage: $(df -h / | tail -1 | awk '{print $5}')"
  echo "Active Connections: $(ss -tun | wc -l)"
  echo "Running Processes: $(ps aux | wc -l)"
}

extract() {
  for archive in $*; do
    if [ -f "$archive" ]; then
      case $archive in
      *.tar.bz2) tar xvjf "$archive" ;;
      *.tar.gz) tar xvzf "$archive" ;;
      *.bz2) bunzip2 "$archive" ;;
      *.rar) rar x "$archive" ;;
      *.gz) gunzip "$archive" ;;
      *.tar) tar xvf "$archive" ;;
      *.tbz2) tar xvjf "$archive" ;;
      *.tgz) tar xvzf "$archive" ;;
      *.zip) unzip "$archive" ;;
      *.Z) uncompress "$archive" ;;
      *.7z) 7z x "$archive" ;;
      *) echo "don't know how to extract '$archive'..." ;;
      esac
    else
      echo "'$archive' is not a valid file!"
    fi
  done
}

# https://gist.github.com/zachbrowne/8bc414c9f30192067831fafebd14255c

# Disable the bell
if [[ $iatest > 0 ]]; then bind "set bell-style visible"; fi

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
