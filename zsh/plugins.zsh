ZDOTDIR="$HOME/.local/share/zsh" # where to store the plugin directories?
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

if [[ ! -d $ZPLUGINDIR/zsh_unplugged ]]; then
  git clone https://github.com/mattmc3/zsh_unplugged $ZPLUGINDIR/zsh_unplugged
fi

# Loads the "manager" itself before the plugins
# contains only the simple plugin-load()
source $ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh

function plugin-update {
  ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.config/zsh/plugins}
  for d in $ZPLUGINDIR/*/.git(/); do
    echo "Updating ${d:h:t}..."
    command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
    echo "------------"
  done
}

source $ZSHROOT/plugins/dirhistory.plugin.zsh
source $ZSHROOT/plugins/fzf-history-search.zsh

# ORDER MATTERS HERE!
# to get lang supported plugins: https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins-Overview
repos=(
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
  zdharma-continuum/fast-syntax-highlighting
  wfxr/forgit
  Aloxaf/fzf-tab
  hlissner/zsh-autopair

  # MichaelAquilina/zsh-you-should-use
  # jeffreytse/zsh-vi-mode
  # bigH/git-fuzzy
  # larkery/zsh-histdb
)

plugin-load $repos
