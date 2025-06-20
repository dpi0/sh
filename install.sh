#!/bin/bash

set -e # Exit immediately on error

SHELL_DIR="$HOME/sh"
CONFIG_DIR="$HOME/.config"

if [ ! -d "$SHELL_DIR" ] || [ ! -d "$CONFIG_DIR" ]; then
  echo "❌ One or both of the required directories do not exist. Exiting."
  exit 1
fi

link() {
  SRC="$1"
  DEST="$2"
  TIMESTAMP=$(date +"%d-%B-%Y_%H-%M-%S")
  BACKUP_PATH="${DEST}_$TIMESTAMP"

  # If it's already the correct symlink, do nothing
  # if [ -L "$DEST" ] && [ "$(readlink "$DEST")" = "$SRC" ]; then
  #   echo "✅ Already correctly linked: $DEST"
  #   return
  # fi

  # If a regular file/directory exists, back it up
  if [ -e "$DEST" ] || [ -L "$DEST" ]; then
    echo "🗂️ Backing up existing: $DEST -> $BACKUP_PATH"
    mv "$DEST" "$BACKUP_PATH"
  fi

  mkdir -p "$(dirname "$DEST")"
  ln -s "$SRC" "$DEST"
  echo "🔗 Symlinked: $SRC -> $DEST"
}

mkdir -p "$CONFIG_DIR/btop" "$CONFIG_DIR/lazygit"

link "$SHELL_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
link "$SHELL_DIR/.vimrc" "$HOME/.vimrc"
link "$SHELL_DIR/btop.conf" "$CONFIG_DIR/btop/btop.conf"
link "$SHELL_DIR/git" "$CONFIG_DIR/git"
link "$SHELL_DIR/yazi" "$CONFIG_DIR/yazi"
link "$SHELL_DIR/lazygit/config.yml" "$CONFIG_DIR/lazygit/config.yml"
link "$SHELL_DIR/zsh/.zshrc" "$HOME/.zshrc"

echo "✅ Dotfiles installation complete."

echo -e "\n 🔵 Essential programs required for proper functioning"
echo "bat, eza, fd, fzf, git, jq, lazygit, rsync, tmux, neovim, yazi, zoxide, zsh"

echo -e "\n 🟣 More useful programs"
echo "btop, croc, duf, gdu, lazydocker, ouch, restic, dust, fastfetch, procs, rclone"

echo -e "\n For more info: cat README.md"
