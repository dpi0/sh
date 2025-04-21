-- return {
--   dir = '/home/dpi0/test/see.nvim',
--   event = 'VeryLazy',
--   opts = {
--     prefix = "<leader>",
--     autosave = true, -- Set to false to disable periodic state saving
--   },
--   keys = {
--     -- Mark buffers
--     {
--       '<leader>1',
--       function()
--         require('see').add_mark '1'
--       end,
--     },
--     {
--       '<leader>2',
--       function()
--         require('see').add_mark '2'
--       end,
--     },
--     {
--       '<leader>3',
--       function()
--         require('see').add_mark '3'
--       end,
--     },
--     {
--       '<leader>4',
--       function()
--         require('see').add_mark '4'
--       end,
--     },
--     {
--       '<leader>5',
--       function()
--         require('see').add_mark '5'
--       end,
--     },
--     {
--       '<leader>6',
--       function()
--         require('see').add_mark '6'
--       end,
--     },
--     {
--       '<leader>7',
--       function()
--         require('see').add_mark '7'
--       end,
--     },
--     {
--       '<leader>8',
--       function()
--         require('see').add_mark '8'
--       end,
--     },
--     {
--       '<leader>9',
--       function()
--         require('see').add_mark '9'
--       end,
--     },
--
--     -- Jump to buffers
--     {
--       '<A-1>',
--       function()
--         require('see').goto_mark '1'
--       end,
--     },
--     {
--       '<A-2>',
--       function()
--         require('see').goto_mark '2'
--       end,
--     },
--     {
--       '<A-3>',
--       function()
--         require('see').goto_mark '3'
--       end,
--     },
--     {
--       '<A-4>',
--       function()
--         require('see').goto_mark '4'
--       end,
--     },
--     {
--       '<A-5>',
--       function()
--         require('see').goto_mark '5'
--       end,
--     },
--     {
--       '<A-6>',
--       function()
--         require('see').goto_mark '6'
--       end,
--     },
--     {
--       '<A-7>',
--       function()
--         require('see').goto_mark '7'
--       end,
--     },
--     {
--       '<A-8>',
--       function()
--         require('see').goto_mark '8'
--       end,
--     },
--     {
--       '<A-9>',
--       function()
--         require('see').goto_mark '9'
--       end,
--     },
--   },
--   config = function(_, opts)
--     require('see').setup(opts)
--   end,
-- }

-- return {
--   'otavioschwanck/arrow.nvim',
--   dependencies = {
--     { 'nvim-tree/nvim-web-devicons' },
--     -- or if using `mini.icons`
--     -- { "echasnovski/mini.icons" },
--   },
--   opts = {
--     show_icons = true,
--     leader_key = ';', -- Recommended to be a single key
--     buffer_leader_key = 'm', -- Per Buffer Mappings
--   },
-- }

return {
  'cbochs/grapple.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', lazy = true },
  },
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Grapple',
  opts = {
    scope = 'git', -- also try out "git_branch"
    icons = true, -- setting to "true" requires "nvim-web-devicons"
    status = true,
  },
  keys = {
    { '<leader>n', '<cmd>Grapple toggle_tags<cr>', desc = 'Toggle tags menu' },
    { '<leader>N', '<cmd>Grapple toggle<cr>', desc = 'Tag a file' },
    -- { '<A-e>', '<cmd>Grapple toggle<cr>', desc = 'Tag a file' },

    { '<A-1>', '<cmd>Grapple select index=1<cr>' },
    { '<A-2>', '<cmd>Grapple select index=2<cr>' },
    { '<A-3>', '<cmd>Grapple select index=3<cr>' },
    { '<A-4>', '<cmd>Grapple select index=4<cr>' },
    { '<A-0>', '<cmd>Grapple select index=5<cr>' },
    { '<A-9>', '<cmd>Grapple select index=6<cr>' },
    { '<A-8>', '<cmd>Grapple select index=7<cr>' },
    { '<A-7>', '<cmd>Grapple select index=8<cr>' },
    { '<A-6>', '<cmd>Grapple select index=9<cr>' },

    -- { '<c-s-n>', '<cmd>Grapple cycle_tags next<cr>', desc = 'Go to next tag' },
    -- { '<c-s-p>', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Go to previous tag' },
  },
}

-- return {
--   'ThePrimeagen/harpoon',
--   -- event = "VeryLazy",
--   branch = 'harpoon2',
--   dependencies = { 'nvim-lua/plenary.nvim' },
--
--   keys = {
--     {
--       '<leader>n',
--       function()
--         require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
--       end,
--       desc = 'Add current buffer to harpoon list',
--     },
--     {
--       -- '<A-S-e>',
--       '<leader>N',
--       function()
--         require('harpoon'):list():add()
--       end,
--       desc = 'Add current buffer to harpoon list',
--     },
--     {
--       '<A-1>',
--       function()
--         require('harpoon'):list():select(1)
--       end,
--       desc = 'Harpoon file 1',
--     },
--     {
--       '<A-2>',
--       function()
--         require('harpoon'):list():select(2)
--       end,
--       desc = 'Harpoon file 2',
--     },
--     {
--       '<A-3>',
--       function()
--         require('harpoon'):list():select(3)
--       end,
--       desc = 'Harpoon file 3',
--     },
--     {
--       '<A-4>',
--       function()
--         require('harpoon'):list():select(4)
--       end,
--       desc = 'Harpoon file 4',
--     },
--     {
--       '<A-0>',
--       function()
--         require('harpoon'):list():select(5)
--       end,
--       desc = 'Harpoon file 5',
--     },
--     {
--       '<A-9>',
--       function()
--         require('harpoon'):list():select(6)
--       end,
--       desc = 'Harpoon file 6',
--     },
--     {
--       '<A-8>',
--       function()
--         require('harpoon'):list():select(7)
--       end,
--       desc = 'Harpoon file 7',
--     },
--   },
--
--   config = function()
--     local harpoon = require 'harpoon'
--     harpoon:setup {}
--   end,
-- }
