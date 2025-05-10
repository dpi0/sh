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
      newfile_status = true,
      path = 2,
      symbols = {
        modified = '[UNSAVED]',
        readonly = '[!READ-ONLY]',
        unnamed = '[No Name]',
        newfile = '[New]',
      },
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
      colored = true, -- enable color
      symbols = {
        added = ' ',
        modified = ' ',
        removed = ' ',
      },
      diff_color = {
        added = { fg = '#98be65' },    -- green
        modified = { fg = '#ECBE7B' }, -- yellow
        removed = { fg = '#FF6C6B' },  -- red
      },
      cond = hide_in_width,
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'kanagawa',
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
        lualine_b = { 'branch', diff },
        lualine_c = {
          {
            'filename',
            file_status = true,
            newfile_status = true,
            path = 0, -- 0 = just filename, 1 = relative, 2 = absolute
            symbols = {
              modified = '[UNSAVED]',
              readonly = '[RO]',
              unnamed = '[No Name]',
              newfile = '[New]',
            },
          },
          'searchcount',
          'selectioncount',
        },
        lualine_x = { diagnostics, { 'filetype', cond = hide_in_width } },
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
