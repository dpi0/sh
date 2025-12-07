#!/usr/bin/env zsh

# https://github.com/romkatv/zsh-bench?tab=readme-ov-file#instant-prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSHROOT="$HOME/.sh/zsh"

source $ZSHROOT/prompts/powerlevel10k/powerlevel10k.zsh-theme
source $ZSHROOT/prompts/custom-p10k.zsh # Customized p10k prompt
source $ZSHROOT/options.zsh
source $ZSHROOT/alias.zsh
source $ZSHROOT/functions.zsh
source $ZSHROOT/binds.zsh
source $ZSHROOT/plugins.zsh
