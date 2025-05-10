#!/use/bin/env zsh

# -----------------------------------------
# use showkey -a to get the shortcut name
# or cat -v
# -----------------------------------------

bindkey -e # sets the ZLE to use Emacs key bindings
# bindkey -v # Enable vi keybindings

copydir() {
  if command -v wl-copy &> /dev/null; then
    print -n $PWD | wl-copy
  else
    echo "wl-copy is not installed. Cannot copy current directory."
  fi
}

copylastcommand() {
  if command -v wl-copy &> /dev/null; then
    fc -ln -1 | tr -d '\n' | wl-copy
  else
    echo "wl-copy is not installed. Cannot copy last command."
  fi
}

copybuffer() {
  if command -v wl-copy &> /dev/null; then
    echo "$BUFFER" | wl-copy
  else
    echo "Error! Couldn't copy current line. wl-copy not present"
  fi
}

go_forward_in_words() {
    local WORDCHARS=${WORDCHARS//[-\/,.:;_=]}
    zle forward-word
}

go_back_in_words() {
    local WORDCHARS=${WORDCHARS//[-\/,.:;_=]}
    zle backward-word
}

delete_word() {
    local WORDCHARS=${WORDCHARS//[-\/,.:;_=]}
    zle backward-delete-word
}

zle -N go_forward_in_words
bindkey '^[[1;5C' go_forward_in_words

zle -N go_back_in_words
bindkey '^[[1;5D' go_back_in_words

zle -N delete_word
bindkey '^[^?' delete_word

zle -N copybuffer
bindkey "^[o" copybuffer

zle -N copydir
bindkey "^Y" copydir

zle -N copylastcommand
bindkey "^[O" copylastcommand

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# zle -N f
# bindkey "^f" f

# zle -N ff
# bindkey "^[f" ff

# zle -N sudo-command-line
# bindkey "\e\e" sudo-command-line

# '^[KEY' means Alt+KEY
bindkey -s '^[v' 'v .^M'
bindkey -s '^[b' 'lf .^M'
bindkey -s '^[B' 'lf $HOME/Screenshots^M'
bindkey -s '^[f' 'jump_to_file^M'
bindkey -s '^[F' 'rga-my-fzf^M'
bindkey -s '^[g' 'rga-my-fzf^M'
bindkey -s '^[d' 'fzf_cd^M'
bindkey -s '^[c' 'jump_to_dir_of_file_tree^M'
bindkey -s '^[D' 'jump_to_dir_of_file^M'
bindkey -s '^[w' '^D'
bindkey -s '^[j' 'z_fzf^M'

# Bind Shift+HJKL to cursor movements
#bindkey -s '^[H' '^[OA'  # Shift+H -> Up
#bindkey -s '^[J' '^[OB'  # Shift+J -> Down
#bindkey -s '^[K' '^[OC'  # Shift+K -> Right
#bindkey -s '^[L' '^[OD'  # Shift+L -> Left

# Bind Ctrl+k to history up (previous command)
bindkey '^k' up-line-or-history
# bindkey 'K' up-line-or-history

# Bind Ctrl+j to history down (next command)
bindkey '^j' down-line-or-history
# bindkey 'J' down-line-or-history

# bindkey '^h' backward-char           # H → Move cursor left
# bindkey '^l' forward-char            # L → Move cursor right

bindkey -M viins '^[^?' backward-kill-word

zvm_vi_yank () {
	zvm_yank
	printf %s "${CUTBUFFER}" |  wl-copy -n
	zvm_exit_visual_mode
}
