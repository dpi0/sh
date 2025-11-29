# HISTORY
HISTFILE=$HOME/.zsh_history         # location of the history file
HISTFILESIZE=100000                 # max number of lines stored in HISTFILE (currently 100,000)
HISTSIZE=100000                     # max number of history entries in-memory session/current shell instance (currently 100,000)
SAVEHIST=50000                      # zsh saves this many lines from the in-memory history list to the history file upon shell exit
HISTTIMEFORMAT="%d/%m/%Y %H:%M] "

setopt EXTENDED_HISTORY             # records the time when each command was executed along with the command itself
setopt APPENDHISTORY                # ensures that each command entered in the current session is appended to the history file immediately after execution
setopt AUTO_CD                      # `cd` by typing directory name
setopt HIST_IGNORE_SPACE            # Commands prefixed with a space are not saved in history
setopt HIST_IGNORE_DUPS             # Don't store duplicate lines consecutively
setopt INC_APPEND_HISTORY           # history file is updated immediately after a command is entered, Acceptable unless you're doing 1000s of commands/sec

# COMPLETION SYSTEM
fpath+=("$HOME/zsh/completion")
autoload -Uz compinit add-zsh-hook
compinit

# PATHS
path+=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/scripts"
  "$HOME/sh/bin"
  "$HOME/bin"
  "$HOME/.deno/bin"
  "$HOME/.nix-profile/bin"
)

export XDG_RUNTIME_DIR=/run/user/$(id -u)

FNM_PATH="$HOME/.local/share/fnm"
if [[ -d $FNM_PATH ]]; then
  path=("$FNM_PATH" $path)
  eval "$(fnm env)"
fi

PNPM_HOME="$HOME/.local/share/pnpm"
if [[ -d $PNPM_HOME && ":$PATH:" != *":$PNPM_HOME:"* ]]; then
  path=("$PNPM_HOME" $path)
fi

if command -v go &> /dev/null; then
  path+=("$(go env GOPATH)/bin")
  export GOPATH="$HOME/go"
fi

if command -v gem &> /dev/null; then
  export GEM_HOME="$(gem env user_gemhome)"
  export GEM_PATH="$GEM_HOME"
  path=("$GEM_HOME/bin" $path)
fi


if command -v opecode &> /dev/null; then
  export PATH=/home/dpi0/.opencode/bin:$PATH
fi

if command -v pnpm &> /dev/null; then
  export PNPM_HOME="/home/dpi0/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi

if command -v kubectl &> /dev/null; then
  export KUBECONFIG=~/.kube/config
fi

# https://wiki.archlinux.org/title/SSH_keys#Start_ssh-agent_with_systemd_user
# first run:
# systemctl --user enable --now ssh-agent.service
# systemctl --user status ssh-agent.service
# THEN REBOOT! (logging out doesn't work)
# have to then add this:
if [[ -z "${SSH_CONNECTION}" ]]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi
# then check: echo $SSH_AUTH_SOCK

# add your keys to stay persistent
if ! ssh-add -l 2>/dev/null | grep -q git-homelab; then
    ssh-add ~/.ssh/git-homelab >/dev/null 2>&1
fi

export PATH="${(j(:))path}"  # Export once, joined with ':'

# ENVIRONMENT VARIABLES
export SCRIPTS="$HOME/scripts"
export GPG_TTY=$(tty)
export TERMINAL=/usr/bin/kitty

# for the plugin: https://github.com/joshskidmore/zsh-fzf-history-search
# ZSH_FZF_HISTORY_SEARCH_BIND='^x'
export PIPENV_VENV_IN_PROJECT=0

if command -v vivid &>/dev/null; then
    export LS_COLORS="$(vivid generate molokai)"
fi

if command -v nvim &>/dev/null; then
    export EDITOR="/usr/bin/nvim"
elif command -v nvim >/dev/null 2>&1; then
    export EDITOR="$(command -v nvim)"
fi

if command -v zoxide &> /dev/null; then
  export _ZO_MAXAGE=100
  export _ZO_EXCLUDE_DIRS="$HOME:$HOME/Downloads:$HOME/.cache:$HOME/.local/share/Trash:/tmp:/var/tmp:/dev:/proc:/sys:/run:/mnt:/media:/lost+found:/"
  eval "$(zoxide init zsh --cmd j)"
fi

if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

export GROFF_NO_SGR=1
export MANPAGER='nvim +Man!'

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
    --color=hl:#FF94BF,hl+:#FF94BF
  "
fi

# fzf-tab config
# https://github.com/Aloxaf/fzf-tab/issues/392
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color always --icons -a -l --time-style relative --changed $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:*:options' fzf-preview
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
	'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
