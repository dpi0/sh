return {
  'dpi0/nee.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' }, -- Used to create the floating window.
  -- opts = {
  --   directory_path = vim.fn.expand '~/temp', -- Defaults to CWD, otherwise add your path to save file in.
  -- },
  keys = {
    {
      '<leader>fi',
      function()
        require('nee').new_file()
      end,
      desc = 'Create New File',
    },
  },
}
