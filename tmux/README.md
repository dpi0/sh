# Tmux

<https://github.com/tmux/tmux/wiki/Getting-Started>

Terminal multiplexer.

```bash
ln -s ~/.sh/tmux ~/.config/

# To apply
tmux kill-server

# Install tpm (Tmux's plugin manager)
git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm
```

Then install the listed plugins in `./plugins.conf` with `PREFIX+ALT+I`
