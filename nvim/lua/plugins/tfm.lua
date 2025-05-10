-- return {
--   -- "tim.nvim", -- Use the actual plugin name or local path
--   dir = "/home/dpi0/test/tim.nvim/",
--   keys = {
--     {
--       "<A-m>",
--       function()
--         require("tim").toggle_fm()
--       end,
--       desc = "Toggle file manager (normal)",
--       mode = "n",
--     },
--     {
--       "<A-m>",
--       "<C-\\><C-n><Cmd>lua require('tim').toggle_fm()<CR>",
--       mode = "t",
--       desc = "Toggle file manager (terminal)",
--     },
--   },
--   opts = {
--     command = "yazi", -- Change to "lf", "ranger", or "nnn" if desired
--   },
--   config = function(_, opts)
--     require("tim").setup(opts)
--   end,
-- }

return {
  'rolv-apneseth/tfm.nvim',
  opts = {
    -- Possible choices: "ranger" | "nnn" | "lf" | "vifm" | "yazi" (default)
    file_manager = 'yazi',
    -- Replace netrw entirely
    -- Default: false
    replace_netrw = true,
    -- Enable creation of commands
    -- Default: false
    -- Commands:
    --   Tfm: selected file(s) will be opened in the current window
    --   TfmSplit: selected file(s) will be opened in a horizontal split
    --   TfmVsplit: selected file(s) will be opened in a vertical split
    --   TfmTabedit: selected file(s) will be opened in a new tab page
    enable_cmds = false,
    -- Custom keybindings only applied within the TFM buffer
    -- Default: {}
    keybindings = {
      ['<ESC>'] = 'q',
      -- Override the open mode (i.e. vertical/horizontal split, new tab)
      -- Tip: you can add an extra `<CR>` to the end of these to immediately open the selected file(s) (assuming the TFM uses `enter` to finalise selection)
      ['<C-v>'] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.vsplit)<CR>",
      ['<C-x>'] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.split)<CR>",
      ['<C-t>'] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.tabedit)<CR>",
    },
    -- Customise UI. The below options are the default
    ui = {
      border = 'rounded',
      height = 1,
      width = 1,
      x = 0.5,
      y = 0.5,
    },
  },
  keys = {
    {
      '<leader>e',
      function()
        require('tfm').open()
      end,
      desc = 'TFM',
    },
    {
      '<leader>E',
      function()
        require('tfm').select_file_manager(vim.fn.input 'Change file manager: ')
      end,
      desc = 'TFM - change selected file manager',
    },
    -- {
    --   "<leader>mh",
    --   function()
    --     local tfm = require("tfm")
    --     tfm.open(nil, tfm.OPEN_MODE.split)
    --   end,
    --   desc = "TFM - horizontal split",
    -- },
    -- {
    --   "<leader>mv",
    --   function()
    --     local tfm = require("tfm")
    --     tfm.open(nil, tfm.OPEN_MODE.vsplit)
    --   end,
    --   desc = "TFM - vertical split",
    -- },
    -- {
    --   "<leader>mt",
    --   function()
    --     local tfm = require("tfm")
    --     tfm.open(nil, tfm.OPEN_MODE.tabedit)
    --   end,
    --   desc = "TFM - new tab",
    -- },
  },
  config = function()
    -- Set keymap so you can open the default terminal file manager (yazi)
    vim.api.nvim_set_keymap('n', '<leader>e', '', {
      noremap = true,
      callback = require('tfm').open,
    })
  end,
}

-- return {
--   'mikavilpas/yazi.nvim',
--   -- dependencies = {
--   --   'folke/snacks.nvim',
--   -- },
--   event = 'VeryLazy',
--   keys = {
--     {
--       '<leader>e',
--       mode = { 'n', 'v' },
--       '<cmd>Yazi<cr>',
--       desc = 'Open yazi at the current file',
--     },
--     {
--       '<leader>E',
--       '<cmd>Yazi toggle<cr>',
--       desc = 'Resume the last yazi session',
--     },
--     opts = {
--       keymaps = {
--         show_help = '<f1>',
--       },
--     },
--   },
-- }
