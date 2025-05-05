return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    indent = {
      enabled = true,
      animate = {
        enabled = vim.fn.has 'nvim-0.10' == 1,
        style = 'out',
        easing = 'linear',
        duration = {
          step = 5,
          total = 200,
        },
      },
    },
    picker = {
      -- In case you want to make sure that the score manipulation above works
      -- or if you want to check the score of each file
      debug = {
        scores = false, -- show scores in the list
      },
      -- I like the "ivy" layout, so I set it as the default globaly, you can
      -- still override it in different keymaps
      layout = {
        preset = 'default',
        -- When reaching the bottom of the results in the picker, I don't want
        -- it to cycle and go back to the top
        cycle = true,
      },
      layouts = {
        -- I wanted to modify the layout width
        --
        vertical = {
          layout = {
            backdrop = false,
            width = 0.8,
            min_width = 80,
            height = 0.8,
            min_height = 30,
            box = 'vertical',
            border = 'rounded',
            title = '{title} {live} {flags}',
            title_pos = 'center',
            { win = 'input', height = 1, border = 'bottom' },
            { win = 'list', border = 'none' },
            { win = 'preview', title = '{preview}', height = 0.4, border = 'top' },
          },
        },
      },
      matcher = {
        frecency = true,
      },
      win = {
        input = {
          keys = {
            -- to close the picker on ESC instead of going to normal mode,
            -- add the following keymap to your config
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
            ['q'] = { 'hide', mode = { 'n', 'i' } },
            -- I'm used to scrolling like this in LazyGit
            ['J'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
            ['K'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
            ['H'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
            ['L'] = { 'preview_scroll_right', mode = { 'i', 'n' } },
          },
        },
      },
      formatters = {
        file = {
          -- filename_first = true, -- display filename before the file path
          truncate = 80,
        },
      },
    },
    lazygit = {
      enabled = true,
      theme = {
        selectedLineBgColor = { bg = 'CursorLine' },
      },
      size = { width = 1, height = 1 },
    },
    quickfile = { enabled = false, exclude = { 'latex' } },
    styles = {
      lazygit = {
        width = 0,
        height = 0,
      },
    },
    -- terminal = { enabled = true },
  },
  keys = {
    {
      -- '<A-u>',
      '<leader>z',
      function()
        Snacks.lazygit { size = { width = 1, height = 1 } }
      end,
      mode = 'n',
      desc = 'Toggle Lazygit (normal)',
      silent = true,
      noremap = true,
    },
    -- {
    -- '<A-u>',
    -- '<C-\\><C-n>:lua Snacks.lazygit(toggle)<CR>',
    -- mode = 't',
    -- desc = 'Toggle Lazygit (terminal)',
    -- silent = true,
    -- noremap = true,
    -- },
    {
      '<leader>lg',
      function()
        require('snacks').lazygit.log()
      end,
      desc = 'Lazygit Logs',
    },
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log {
          finder = 'git_log',
          format = 'git_log',
          preview = 'git_show',
          confirm = 'git_checkout',
          layout = 'vertical',
        }
      end,
      desc = 'Git Log',
    },
    {
      '<leader>rN',
      function()
        require('snacks').rename.rename_file()
      end,
      desc = 'Fast Rename Current File',
    },
    {
      '<leader>go',
      function()
        require('snacks').gitbrowse()
      end,
      desc = 'Open current file in the respective GitHub repo',
    },
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>>',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
    { '<leader>e', false },
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches {
          layout = 'select',
        }
      end,
      desc = 'Branches',
    },
    {
      '<leader><Space>',
      function()
        Snacks.picker.files {
          finder = 'files',
          format = 'file',
          show_empty = true,
          supports_live = true,
          -- In case you want to override the layout for this keymap
          -- layout = "vscode",
        }
      end,
      desc = 'Find Files',
    },
    -- {
    --   '<S-h>',
    --   function()
    --     Snacks.picker.buffers {
    --       -- I always want my buffers picker to start in normal mode
    --       on_show = function()
    --         vim.cmd.stopinsert()
    --       end,
    --       finder = 'buffers',
    --       format = 'buffer',
    --       hidden = false,
    --       unloaded = true,
    --       current = true,
    --       sort_lastused = true,
    --       win = {
    --         input = {
    --           keys = {
    --             ['d'] = 'bufdelete',
    --           },
    --         },
    --         list = { keys = { ['d'] = 'bufdelete' } },
    --       },
    --       -- In case you want to override the layout for this keymap
    --       -- layout = "ivy",
    --     }
    --   end,
    --   desc = '[P]Snacks picker buffers',
    -- },
  },
}
