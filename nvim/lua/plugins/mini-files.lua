return {
  'echasnovski/mini.files',
  version = '*',
  config = function()
    require('mini.files').setup {
      -- Customization of explorer windows
      windows = {
        -- Maximum number of windows to show side by side
        max_number = math.huge,
        -- Whether to show preview of file/directory under cursor
        preview = true,
        -- Width of focused window
        width_focus = 30,
        -- Width of non-focused window
        width_nofocus = 15,
        -- Width of preview window
        width_preview = 60,
      },
    }
  end,
  keys = {
    {
      '<leader>o',
      function()
        require('mini.files').open()
      end,
      desc = 'Mini Files',
    },
  },
}
