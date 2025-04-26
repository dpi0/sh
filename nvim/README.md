## Neovim Configuration

![nvim-config-screenshot](https://github.com/user-attachments/assets/076de815-88d6-499b-9341-8a0dec2a7c2b)

### Installation

```bash
curl -fsSL bin.dpi0.cloud/nvim | sh
```

### Directory Structure

```text
~/.config/nvim/
├── init.lua                  # Entry point
├── lua/
│   └── core/                 # Core settings
│       ├── options.lua       # Editor options
│       ├── binds.lua         # Key mappings
│       ├── snippets.lua      # Snippet definitions
│       └── autocmd.lua       # Autocommands
│   └── plugins/              # Plugin configurations
│       ├── alpha.lua
│       ├── lualine.lua
│       └── ...               # Other plugin configs
├── after/
│   └── ftplugin/             # Filetype-specific settings
│       └── filetype.lua
└── stylua.toml               # StyLua configuration

```

- `init.lua` is the entrypoint.
- it loads the lazyvim plugin manager, `./lua/core/options.lua`, `./lua/core/autocmd.lua`, `./lua/core/binds.lua`, `./lua/core/snippets.lua` and modular plugins.
- plugins are present in `./lua/plugins/` where each file returns a lua table.
- some plugins are limited to a machine with a particular hostname like `arch`.

### Plugins

#### Dashboard

| Plugin                                                      | Description                                      |
| ----------------------------------------------------------- | ------------------------------------------------ |
| [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim) | Fast and highly customizable greeter for Neovim. |

#### Color & Icons

| Plugin                                                                          | Description                              |
| ------------------------------------------------------------------------------- | ---------------------------------------- |
| [norcalli/nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)   | Fast highlighter for color codes.        |
| [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)         | Highlight and search for TODO comments.  |
| [kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) | Lua fork of vim-web-devicons for neovim. |

#### LSP & Autocompletion

| Plugin                                                                                | Description                                                                                |
| ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                     | Quickstart configurations for the built-in LSP client.                                     |
| [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                               | Autocompletion plugin for Neovim.                                                          |
| [jose-elias-alvarez/null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim) | Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua. |

#### Fuzzy Finder

| Plugin                                                  | Description                      |
| ------------------------------------------------------- | -------------------------------- |
| [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua) | Improved fzf.vim written in Lua. |

#### Mini Plugins

| Plugin                                                                    | Description                                          |
| ------------------------------------------------------------------------- | ---------------------------------------------------- |
| [echasnovski/mini.ai](https://github.com/echasnovski/mini.ai)             | Neovim plugin for a smarter 'a' and 'i' textobjects. |
| [echasnovski/mini.files](https://github.com/echasnovski/mini.files)       | File explorer plugin for Neovim.                     |
| [echasnovski/mini.surround](https://github.com/echasnovski/mini.surround) | Plugin for managing surrounding characters.          |

#### Marks & Navigation

| Plugin                                                          | Description                                                 |
| --------------------------------------------------------------- | ----------------------------------------------------------- |
| [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon) | Quick file navigation.                                      |
| [chentoast/marks.nvim](https://github.com/chentoast/marks.nvim) | A better user experience for navigating and managing marks. |

#### Productivity

| Plugin                                                                  | Description                                                                   |
| ----------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)       | Smart and powerful comment plugin.                                            |
| [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)       | Autopairs for Neovim written in Lua.                                          |
| [folke/which-key.nvim](https://github.com/folke/which-key.nvim)         | Displays a popup with possible keybindings of the command you started typing. |
| [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight and search for TODO comments.                                       |
| [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)       | Useful lua functions used by lots of plugins.                                 |

#### Statusline

| Plugin                                                                    | Description                                                            |
| ------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | A blazing fast and easy to configure Neovim statusline written in Lua. |
