require 'core.options'
require 'core.binds'
require 'core.snippets'
require 'core.autocmd'

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

local hostname = vim.loop.os_gethostname()

-- Define the base plugins
local plugins = {
  require 'plugins.alpha', -- Startup dashboard for Neovim.
  require 'plugins.autopairs', -- Auto-closes brackets and quotes.
  require 'plugins.colorizer', -- Highlights color codes in files.
  require 'plugins.colortheme', -- Sets the color scheme for the editor.
  require 'plugins.comment', -- Simplifies code commenting.
  require 'plugins.cursorline', -- Highlights the current cursor line.
  -- require 'plugins.gitsigns', -- Shows Git changes in the gutter.
  require 'plugins.indent', -- Displays indentation guides.
  require 'plugins.lualine', -- Statusline enhancement.
  require 'plugins.multicursors', -- Enables multiple cursors for editing.
  -- require("plugins.neoterm"), -- Manages terminal buffers.
  require 'plugins.oil', -- File explorer integration.
  -- require("plugins.todo-comments"), -- Highlights codes, comments etc
  require 'plugins.which-key', -- Displays available keybindings.
  -- require 'plugins.todo', -- Todo with Todone.
  require 'plugins.tfm', -- Use any terminal File Manager (currently using Yazi).
  -- require("plugins.diff"), -- Better diff (than gitsigns).
  -- require("plugins.surround"), -- Surround.
  require 'plugins.flash-jump', -- Jump quickly to text.
  -- require("plugins.fold"), -- Modern code folding.
  require 'plugins.snacks', -- QoL.
  -- require 'plugins.session', -- Manage sessions.
  -- require("plugins.zen"), -- Center.
  -- require("plugins.upload"), -- Nup - Upload files, yanks and selections to WantGuns/bin.
  -- require("plugins.file-manage-eunuch"), -- Perform various actions on the current file.
  require 'plugins.sudo', -- Write/Edit to unprivileged files with sudo.
  require 'plugins.fzf', -- Fzf lua.
  -- require("plugins.git-vim-fugitive"), -- Vim-fugitive.
  require 'plugins.markdown-keybinds', -- Markdown keybindings.
  require 'plugins.fim', -- Floating Terminal.
  require 'plugins.harpoon', -- Quickly switch b/w multiple files.
  -- require 'plugins.marks', -- Better Marks.
  -- require("plugins.clipboard"), -- Neogit clipboard.
  -- require 'plugins.undo', -- Undo tree.
  -- require("plugins.screensaver"), -- Drop Screensaver to show when idle.
  -- require("plugins.tiny-diagnose"), -- Tiny inline diagnostic messages.
  -- require 'plugins.mini-ai', -- Mini A/I objects.
  -- require 'plugins.mini-files', -- Mini Files.
  require 'plugins.mini-surround', -- Mini Surround Brackets.
  -- require 'plugins.snippets', -- Snippets.
  require 'plugins.screenshot', -- Screenshot Code Snippet.
  -- require 'plugins.todoo', -- Tddo from vimichael/my-nvim-config.
  require 'plugins.plenary', -- Plenary (useful dependency)
}

-- Conditionally add if hostname is "arch"
if hostname == 'arch' then
  -- TELESCOPE requires build-essential (debian, ~300M) or base-devel (arch, ~260M)
  -- table.insert(plugins, require("plugins.telescope")) -- Fuzzy finder and picker.
  table.insert(plugins, require 'plugins.lsp') -- Language Server Protocol.
  table.insert(plugins, require 'plugins.treesitter') -- Better syntax highlighting and code understanding.
  table.insert(plugins, require 'plugins.autocompletion') -- Autocompletion support.
  table.insert(plugins, require 'plugins.none-ls-formatter') -- Code formatting.
  table.insert(plugins, require 'plugins.markdown') -- Markdown render.
  -- table.insert(plugins, require("plugins.diagnose")) -- Diagnosis Trouble.
  -- table.insert(plugins, require("plugins.noice")) -- Noice.
  table.insert(plugins, require 'plugins.activity-watcher') -- Activity Tracker Watcher Plugin.
  -- table.insert(plugins, require 'plugins.obsidian') -- Obsidian.
end

-- Load all plugins at once
require('lazy').setup(plugins)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
