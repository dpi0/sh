PS1='\[\e[38;5;39m\]\u\[\e[0m\]@\[\e[38;5;135m\]\h\[\e[0m\] in \[\e[38;5;220;1m\]\w\[\e[0m\] at \[\e[38;5;154m\]\t\[\e[0m\] \\$ '

alias ..='cd ..'
alias ...='cd ../..'
alias md='mkdir -p'
alias lf="yazi"
alias slf="-E yazi"
alias tx="tmux"
alias re="source ~/.bashrc && exec bash"
alias lz="lazygit"
alias fd='fd -H'
alias v="nvim"
alias vim="nvim"
alias svim="-E nvim"
alias k="kubectl"
alias kx="kubectx"
alias kns="kubens"
alias fz="fzf --preview-window=hidden"
alias c='clear'
alias oc='opencode'
alias h="helm"
alias p='pacman'
alias py="python3"
alias d="docker"
alias di="docker image"
alias dpsa="docker ps -a"
alias de="docker exec"
alias dc="docker compose"
alias dn="docker network"
alias dv="docker volume"
alias g='git'
alias ga='git add'
alias gcl='git clone'
alias gcmt='git commit --verbose'
alias gf='git fetch'
alias gfo='git fetch origin'
alias gm='git merge'
alias gl='git pull'
alias gp='git push'
alias gpv='git push --verbose'
alias gr='git remote'
alias grv='git remote --verbose'
alias gst='git status'
alias uncommit="git reset HEAD~1"             # Undo the last commit, keep changes staged
alias recommit="git commit --amend --no-edit" # Amend last commit without changing message
alias editcommit="git commit --amend"         # Amend last commit and edit message
alias undocommit="git reset --soft HEAD~1"    # Undo last commit, keep changes staged

if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend
shopt -s cmdhist

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
