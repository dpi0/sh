return {
  'dpi0/zox.nvim',
  lazy = true,
  dependencies = { 'ibhagwan/fzf-lua' },
  opts = {
    fzf_opts = {
      prompt = 'Zoxide> ',
      winopts = {
        height = 0.5,      -- window height
        width = 0.5,       -- window width
        row = 0.5,         -- center vertically
        col = 0.5,         -- center horizontally
        anchor = 'center', -- anchor point is center
        border = 'rounded',
      },
    },
  },
  keys = {
    {
      '<leader>o',
      function()
        require('zox').fuzzy_find_dir()
      end,
      desc = 'Zoxide Fzf',
    },
  },
}
