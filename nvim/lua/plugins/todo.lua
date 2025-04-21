return {
  dir = '/home/dpi0/test/doo.nvim/',
  -- name = 'doo.nvim',
  dependencies = {
    'ibhagwan/fzf-lua', -- Ensure this is installed
  },
  lazy = false,
  config = function()
    require('doo').setup()
  end,
}

-- return {
--   'ntocampos/todone.nvim',
--   dependencies = {
--     -- Either one or the other
--     -- { "nvim-telescope/telescope.nvim", optional = true },
--     { 'folke/snacks.nvim', optional = true },
--   },
--   opts = {
--     root_dir = '~/.local/share/nvim/todo',
--     float_position = 'topright',
--   },
--   keys = {
--     { '<leader>tt', '<cmd>TodoneToday<cr>', desc = "Open today's notes" },
--     { '<leader>tf', '<cmd>TodoneToggleFloat<cr>', desc = 'Toggle priority float' },
--     -- The commands below require a picker
--     { '<leader>tl', '<cmd>TodoneList<cr>', desc = 'List all notes' },
--     { '<leader>tg', '<cmd>TodoneGrep<cr>', desc = 'Search inside all notes' },
--     { '<leader>tp', '<cmd>TodonePending<cr>', desc = 'List notes with pending tasks' },
--   },
-- }

-- return {
--   dir = '/home/dpi0/test/doo.nvim/',
--   dependencies = { 'ibhagwan/fzf-lua' },
--   opts = {
--     -- Optional: customize default options
--     -- doo_dir = "~/.local/share/nvim/doo/",  -- Default location to store todo files
--     -- project_depth = 2,                     -- Number of directory levels to use for filename
--   },
--   keys = {
--     {
--       '<leader>T',
--       function()
--         require('doo').open_doo()
--       end,
--       desc = 'Open directory todo',
--     },
--     {
--       '<leader>tf',
--       function()
--         require('doo').list_doos()
--       end,
--       desc = 'List all todos',
--     },
--   },
--   lazy = true, -- Only load on keybind usage
-- }
