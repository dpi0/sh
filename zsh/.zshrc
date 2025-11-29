#!/usr/bin/env zsh

# let it stay on top & READ THIS: for why this is so cool- https://github.com/romkatv/zsh-bench?tab=readme-ov-file#instant-prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# laods powerlevel10k prompt
source $HOME/sh/zsh/prompts/powerlevel10k/powerlevel10k.zsh-theme

export ZSHROOT="$HOME/sh/zsh"

source $ZSHROOT/prompts/custom-p10k.zsh # laods custom theme for p10k
source $ZSHROOT/options.zsh
source $ZSHROOT/alias.zsh
source $ZSHROOT/functions.zsh
source $ZSHROOT/binds.zsh
source $ZSHROOT/plugins.zsh

# pnpm
# pnpm end
