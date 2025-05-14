if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    read -k 1 "tmux_choice?Start tmux? Restore? (y/n/r) "
    echo
    if [[ "$tmux_choice" == [yY] ]]; then
        sessions=$(tmux list-sessions -F '#S' 2>/dev/null)
        if [[ -n "$sessions" ]]; then
            echo -n "Select tmux session: "
            session_name=$(echo "$sessions" | fzf \
                --prompt='' \
                --height=15 \
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
    elif [[ "$tmux_choice" == [rR] ]]; then
        # Check if tmux-resurrect is installed
        resurrect_path="${HOME}/.tmux/plugins/tmux-resurrect/resurrect.tmux"
        if [[ -f "$resurrect_path" ]]; then
            # Start tmux server if it's not already running
            tmux start-server
            # Attempt to restore the last saved tmux session
            tmux new-session \; run-shell $HOME/.tmux/plugins/tmux-resurrect/scripts/restore.sh
        else
            echo "tmux-resurrect plugin not found. Please install it first."
        fi
    fi
fi
