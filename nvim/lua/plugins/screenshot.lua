return {
  'charm-and-friends/freeze.nvim',
  keys = {
    {
      '<leader>sc',
      ':Freeze<cr>',
      mode = 'v',
      desc = 'Screenshot Code',
      silent = true,
    },
  },
  config = function()
    require('freeze').setup {
      command = 'freeze',
      open = true,
      output = function()
        local home = os.getenv 'HOME'
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t'):gsub('%s+', '_')

        -- Correctly get visual selection start and end
        local start_line = vim.fn.getpos("'<")[2]
        local end_line = vim.fn.getpos("'>")[2]
        if start_line > end_line then
          start_line, end_line = end_line, start_line
        end

        local line_range = string.format('line-%d-to-%d', start_line, end_line)
        local timestamp = os.date '%H-%M-%S'
        local date = os.date '%d-%b'

        return string.format('%s/Screenshots/%s_%s_(%s)_(%s).png', home, filename, line_range, timestamp, date)
      end,
      font = {
        family = 'JetBrains Mono Nerd Font',
        size = 16,
      },
      padding = '20',
      theme = 'gruvbox',
      line_height = 1.4,
      show_line_numbers = true,
      window = true,
    }
  end,
}

-- return {
--   'michaelrommel/nvim-silicon',
--   lazy = true,
--   cmd = 'Silicon',
--   main = 'nvim-silicon',
--   config = function()
--     local home = os.getenv 'HOME' or vim.env.HOME
--     require('nvim-silicon').setup {
--       disable_defaults = false,
--       -- turn on debug messages
--       debug = false,
--       -- rest of the config goes here...
--       font = 'JetBrainsMono Nerd Font',
--       -- theme = "Monokai Extended",
--       --  get the list of themes using `silicon --list-themes`
--       theme = 'gruvbox-dark',
--       pad_horiz = 10,
--       pad_vert = 10,
--       background = '#54546D',
--       -- may bug out on WSL2
--       to_clipboard = true,
--       window_title = function()
--         return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ':t')
--       end,
--       output = function()
--         local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ':t')
--         return home .. '/Screenshots/' .. filename .. ' (' .. os.date '%H-%M-%S' .. ') (' .. os.date '%d-%b' .. ').png'
--       end,
--     }
--     -- vim.keymap.set("v", "<leader>z", function()
--     --   require("nvim-silicon").file()
--     -- end, { desc = "Save code screenshot as file" })
--     -- vim.keymap.set("v", "<leader>sc", function()
--     --   require("nvim-silicon").clip()
--     -- end, { desc = "Copy code screenshot to clipboard" })
--     -- vim.keymap.set("v", "<leader>ss", function()
--     --   require("nvim-silicon").shoot()
--     -- end, { desc = "Create code screenshot" })
--   end,
-- }
