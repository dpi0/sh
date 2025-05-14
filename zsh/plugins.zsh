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

source $ZSHROOT/plugins/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh
source $ZSHROOT/plugins/dirhistory/dirhistory.plugin.zsh
# to work with this on arch linux, install `pkgfile` and run `sudo pkgfile --update`
source $ZSHROOT/plugins/command-not-found/command-not-found.plugin.zsh
source $ZSHROOT/plugins/cp/cp.plugin.zsh
source $ZSHROOT/plugins/direnv/direnv.plugin.zsh
source $ZSHROOT/plugins/fastfile/fastfile.plugin.zsh
source $ZSHROOT/plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh

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
