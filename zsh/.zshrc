if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    read -k 1 "tmux_choice?Start tmux? (y/n) "
    echo
    if [[ "$tmux_choice" == [yY] ]]; then
        sessions=$(tmux list-sessions -F '#S' 2>/dev/null)
        if [[ -n "$sessions" ]]; then
            echo -n "Select tmux session: "
            session_name=$(echo "$sessions" | fzf \
                --prompt='' \
                --height=12 \
                --reverse \
                --inline-info \
                --preview="tmux list-windows -t {}" \
                --preview-window=right:60%:wrap \
                --header=$'Ctrl-E to create a new tmux session. ESC to cancel' \
                --expect=ctrl-e \
                --border)

            key=$(head -1 <<< "$session_name")
            selection=$(tail -n +2 <<< "$session_name")

            if [[ "$key" == ctrl-e ]]; then
                print -n "New session name: "
                read new_name
                if [[ -z "$new_name" ]]; then
                    echo "No session name entered. Skipping tmux."
                elif tmux has-session -t "$new_name" 2>/dev/null; then
                    echo "Session '$new_name' already exists. Attaching..."
                    tmux -u attach -t "$new_name"
                else
                    tmux -u new -s "$new_name"
                fi
            elif [[ -n "$selection" && "$sessions" == *"$selection"* ]]; then
                tmux -u attach -t "$selection" || echo "Failed to attach to session: $selection"
            else
                echo "No session selected. Skipping tmux."
            fi
        else
            print -n "No sessions found. New session name: "
            read new_name
            if [[ -z "$new_name" ]]; then
                echo "No session name entered. Skipping tmux."
            elif tmux has-session -t "$new_name" 2>/dev/null; then
                echo "Session '$new_name' already exists. Attaching..."
                tmux -u attach -t "$new_name"
            else
                tmux -u new -s "$new_name"
            fi
        fi
    fi
fi

# Change prompt if the hostname is not arch
if [[ "$(cat /etc/hostname)" != "titan" ]]; then
    PROMPT="%F{#009dff}%n%F{#00ff59}@%m %F{#ffea00}in %~ %F{reset}$ "
else
    # let it stay on top & READ THIS: for why this is so cool- https://github.com/romkatv/zsh-bench?tab=readme-ov-file#instant-prompt
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
	source $HOME/sh/zsh/powerlevel10k/powerlevel10k.zsh-theme
fi

export ZSHROOT="$HOME/sh/zsh"
export DOTFILES="$HOME/.dotfiles"

source $ZSHROOT/options.sh
source $ZSHROOT/alias.sh
source $ZSHROOT/functions.sh
source $ZSHROOT/binds.sh
source $ZSHROOT/themes/lean-p10k.zsh # same as ~/.p10k.zsh in the docs
# source $ZSHROOT/themes/robbby-russell-p10k.zsh
source $ZSHROOT/plugin-manager.sh
source $ZSHROOT/plugins/dirhistory.plugin.zsh
source $ZSHROOT/plugins/fzf-history-search.zsh

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
