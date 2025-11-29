zle -N go_forward_in_words # Register the widget for zsh
zle -N go_back_in_words
zle -N delete_word
zle -N copybuffer
zle -N copydir
zle -N copylastcommand
bindkey -e                                   # sets the ZLE to use Emacs key bindings
bindkey '^[[1;5C' go_forward_in_words        # Ctrl+Right to jump forward by word
bindkey '^[[1;5D' go_back_in_words           # Ctrl+Left to jump backward by word
bindkey '^[^?' delete_word                   # Alt+Backspace to delete previous word
bindkey "^[o" copybuffer                     # Alt+o to copy current buffer
bindkey "^Y" copydir                         # Ctrl+Y to insert current directory
bindkey "^[O" copylastcommand                # Alt+Shift+O to copy last command
bindkey '^[[A' history-substring-search-up   # Up arrow for substring search backward
bindkey '^[[B' history-substring-search-down # Down arrow for substring search forward
bindkey -s '^[v' 'nvim .^M'                  # ALTv to open neovim in $PWD
bindkey -s '^[f' 'jump_to_file^M'            # ALT+f to find files
bindkey -s '^[F' 'fzf_cd^M'                  # ALT+SHIFT=f to cd into that file's parent dir
bindkey -s '^[j' 'jump_to_dir^M'             # ALT+j for zoxide+fzf
bindkey -s '^[k' 'txa^M'                     # ALT+k to switch tmux sessions with fzf
bindkey -s 'L' '\e[C'                        # Bind Shift+L (capital L) to forward-char (→)
