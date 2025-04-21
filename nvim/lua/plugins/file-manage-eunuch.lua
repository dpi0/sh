return {
  'tpope/vim-eunuch',
  keys = {
    {
      '<leader>df',
      '<cmd>Remove<CR>',
      mode = 'n',
      desc = 'Remove file from disk (avoids E211)',
    },
    {
      '<leader>cm',
      '<cmd>Chmod<CR>',
      mode = 'n',
      desc = 'Change permissions of current file',
    },
    {
      '<leader>dF',
      '<cmd>Delete<CR>',
      mode = 'n',
      desc = 'Delete file and close buffer',
    },
  },
}
