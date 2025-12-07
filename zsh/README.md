# Zsh

Shell.

```bash
ln -sf ~/.sh/zsh/.zshrc ~/.zshrc
```

Install powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.sh/zsh/prompts/powerlevel10k

# Fully reload shell
exec zsh
```

This configuration uses a custom [not really a plugin manager](https://github.com/mattmc3/zsh_unplugged#bulb-the-simple-idea) by mattmc3 called [zsh_unplugged](https://github.com/mattmc3/zsh_unplugged).

This is defined in `./plugins.zsh` along with the plugins installed.

Some plugins are being manually installed via `./plugins/`
