return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local mode_map = {
      ['NORMAL'] = 'N',
      ['INSERT'] = 'I',
      ['VISUAL'] = 'V',
      ['V-LINE'] = 'V-L',
      ['V-BLOCK'] = 'V-B',
      ['REPLACE'] = 'R',
      ['COMMAND'] = 'C',
      ['TERMINAL'] = 'T',
      ['SELECT'] = 'S',
    }

    local mode = {
      'mode',
      fmt = function(str)
        return (mode_map[str] or str:sub(1, 1))
      end,
    }

    local filename = {
      'filename',
      file_status = true,
      path = 2,
      fmt = function(name)
        local home = vim.fn.expand '$HOME'
        return name:gsub('^' .. home, '~')
      end,
      -- color the file name
      -- color = { fg = vim.fn.synIDattr(vim.fn.hlID 'Directory', 'fg', 'gui') },
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      colored = false,
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      'diff',
      colored = false,
      symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
      cond = hide_in_width,
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'kanagawa', -- Set theme based on environment variable
        -- Some useful glyphs:
        -- https://www.nerdfonts.com/cheat-sheet
        --        
        -- section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
        refresh = {
          statusline = 100,
        },
        disabled_filetypes = { 'alpha', 'neo-tree' },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { 'branch' },
        -- lualine_c = { { 'filename', path = 2 } },
        lualine_c = { filename },
        lualine_x = { diagnostics, diff, { 'encoding', cond = hide_in_width }, { 'filetype', cond = hide_in_width } },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 2 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'fugitive', 'quickfix', 'fzf', 'lazy', 'mason', 'nvim-dap-ui', 'oil', 'trouble' },
    }
  end,
}
