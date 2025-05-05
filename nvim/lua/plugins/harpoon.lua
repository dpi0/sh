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
    { '<leader>ni', '<cmd>Grapple toggle_tags<cr>', desc = 'Toggle tags menu' },
    { '<leader>na', '<cmd>Grapple toggle<cr>', desc = 'Tag a file' },
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
