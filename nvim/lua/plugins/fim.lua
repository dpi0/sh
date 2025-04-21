return {
  -- dir = "/home/dpi0/test/fim.nvim/",
  'dpi0/fim.nvim',
  keys = {
    -- Terminal 1 keybindings
    { '<A-y>', '<cmd>FimTerm 1<CR>', mode = 'n', desc = 'Toggle terminal 1 (normal)' },
    { '<A-y>', '<C-\\><C-n><cmd>FimTerm 1<CR>', mode = 't', desc = 'Toggle terminal 1 (terminal)' },
    { '<A-y>', '<Esc><cmd>FimTerm 1<CR>', mode = 'i', desc = 'Toggle terminal 1 (insert)' },

    -- Terminal 2 keybindings
    { '<A-i>', '<cmd>FimTerm 2<CR>', mode = 'n', desc = 'Toggle terminal 2 (normal)' },
    { '<A-i>', '<C-\\><C-n><cmd>FimTerm 2<CR>', mode = 't', desc = 'Toggle terminal 2 (terminal)' },
    { '<A-i>', '<Esc><cmd>FimTerm 2<CR>', mode = 'i', desc = 'Toggle terminal 2 (insert)' },
  },
  config = function()
    require('fim').setup {
      opts = {
        width = 0.7,
        height = 0.7,
      },
    }
  end,
}
