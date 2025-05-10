#!/usr/bin/env zsh

HISTFILE=~/.zsh_history # location of the history file
HISTFILESIZE=1000000000 # history limit of the file on disk
HISTSIZE=1000000000 # current session's history limit
SAVEHIST=500000 # zsh saves this many lines from the in-memory history list to the history file upon shell exit
HISTTIMEFORMAT="%d/%m/%Y %H:%M] "

setopt INC_APPEND_HISTORY # history file is updated immediately after a command is entered
setopt SHARE_HISTORY # allows multiple Zsh sessions to share the same command history 
setopt EXTENDED_HISTORY # records the time when each command was executed along with the command itself
setopt APPENDHISTORY # ensures that each command entered in the current session is appended to the history file immediately after execution

setopt autocd

fpath+=("$HOME/zsh/completion")
autoload -Uz _rmi
autoload -Uz compinit && compinit
autoload -Uz add-zsh-hook

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/scripts"
export PATH="$PATH:$HOME/sh/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.deno/bin"
export PATH="$PATH:$HOME/.nix-profile/bin"

export CONFIG="$HOME/.config"
export SCRIPTS="$HOME/scripts"
export VOLUMES="$HOME/docker_volumes"
# export TERMINAL=/usr/bin/foot

export GPG_TTY=$(tty)

if command -v python &>/dev/null; then
  export PIPENV_VENV_IN_PROJECT=0
fi

if command -v vivid &>/dev/null; then
    export LS_COLORS="$(vivid generate molokai)"
fi

if command -v nvim &>/dev/null; then
    export EDITOR="/usr/bin/nvim"
elif command -v nvim >/dev/null 2>&1; then
    export EDITOR="$(command -v nvim)"
fi

if command -v go &> /dev/null; then
  export PATH=$PATH:$(go env GOPATH)/bin
  export GOPATH="$HOME/go"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh --cmd j)"
fi

if command -v gem &> /dev/null; then
  export GEM_HOME="$(gem env user_gemhome)"
  export PATH="$PATH:$GEM_HOME/bin"
fi

# https://github.com/junegunn/fzf.vim/issues/358#issuecomment-841665170
if command -v fzf &> /dev/null; then
   # command -v bat &> /dev/null && \
   # command -v fd &> /dev/null; then
  export FZF_DEFAULT_OPTS="
    --layout=reverse
    --preview='bat --style=numbers --color=always --line-range :500 {}'
    --preview-window='right:50%'
    --ansi
    --extended
    --bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,shift-up:preview-top,shift-down:preview-bottom
  "

  export FZF_DEFAULT_COMMAND="fd --hidden --color=always \
    --exclude node-modules \
    --exclude go/pkg/mod \
    --exclude .local/share \
    --exclude .local/state \
    --exclude .vscode \
    --exclude .config/Code \
    --exclude .Trash-1000 \
    --exclude .git \
    --exclude .cargo \
    --exclude .rustup \
    --exclude .cache \
    --exclude .cargo \
    --exclude .mozilla \
    --exclude .npm \
    --exclude .cache"
fi
