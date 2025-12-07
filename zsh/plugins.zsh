ZDOTDIR="$HOME/.local/share/zsh" # Directory to save the plugins
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

if [[ ! -d $ZPLUGINDIR/zsh_unplugged ]]; then
  git clone https://github.com/mattmc3/zsh_unplugged $ZPLUGINDIR/zsh_unplugged
fi

source $ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh

function plugin-update {
  ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.config/zsh/plugins}
  for d in $ZPLUGINDIR/*/.git(/); do
    echo "Updating ${d:h:t}..."
    command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
    echo "------------"
  done
}

# Manually loading
source $ZSHROOT/plugins/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh
source $ZSHROOT/plugins/dirhistory/dirhistory.plugin.zsh
source $ZSHROOT/plugins/direnv/direnv.plugin.zsh

repos=(
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
  zdharma-continuum/fast-syntax-highlighting
  Aloxaf/fzf-tab
  hlissner/zsh-autopair
)

plugin-load $repos
