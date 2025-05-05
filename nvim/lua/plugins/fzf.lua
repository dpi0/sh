return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    previewers = {
      builtin = {
        syntax_limit_b = 1024 * 100, -- 100KB limit on previews.
      },
    },
    -- winopts = {
    --   -- using bat_native or bat improves the performance.
    --   -- according to fzf-lua docs. see: https://github.com/ibhagwan/fzf-lua/wiki#how-do-i-get-maximum-performance-out-of-fzf-lua
    --   preview = { default = "bat_native", border = "none" },
    -- },
    fzf_opts = { ['--cycle'] = true },
    grep = {
      rg_glob = true, -- enable glob parsing
      glob_flag = '--iglob', -- case insensitive globs
      glob_separator = '%s%-%-', -- query separator pattern (lua): ' --'
      cmd = 'rg --line-number --column --no-heading --color=always',
      rg_opts = table.concat({
        '--hidden', -- if you want to include hidden files (optional)
        '--no-ignore-vcs', -- optional, to ignore .gitignore
        '--glob=!**/.local/**',
        '--glob=!**/.rustup/**',
        '--glob=!**/node_modules/**',
        '--glob=!**/.cargo/**',
        '--glob=!**/.continue/**',
        '--glob=!**/.mozilla/**',
        '--glob=!**/go/pkg/mod/**',
        '--glob=!**/Code/User/**',
        '--glob=!**/.git/**',
        '--glob=!**/.npm/**',
        '--glob=!**/.cache/**',
      }, ' '),
    },
    files = {
      cmd = table.concat({
        'fd --type f --hidden --follow',
        '--exclude .git',
        '--exclude node_modules',
        '--exclude .cargo',
        '--exclude .mozilla',
        '--exclude .cache',
        '--exclude .npm',
        '--exclude .rustup',
        '--exclude go/pkg/mod',
        '--exclude Code/User',
        '--exclude .local',
        '--exclude .continue',
      }, ' '),
    },
    defaults = {
      git_icons = true,
      file_icons = true,
      color_icons = true,
    },
    keymap = {
      builtin = {
        ['<S-j>'] = 'preview-page-down',
        ['<S-k>'] = 'preview-page-up',
        -- ["<M-S-down>"] = "preview-down",
        -- ["<M-S-up>"] = "preview-up",
        -- ["ctrl-k"] = "up",
        -- ["ctrl-j"] = "down",
        -- ["ctrl-q"] = "abort",
      },
      -- fzf = {
      --   ["<A-k>"] = "preview-page-up",
      --   ["<A-j>"] = "preview-page-down",
      -- },
    },
  },
  keys = {
    {
      '<leader>fzf',
      function()
        require('fzf-lua').builtin()
      end,
      desc = 'FzfLua ❤️',
    },
    {
      '<A-f>',
      function()
        require('fzf-lua').files {
          winopts = {
            height = 0.9, -- window height
            width = 0.9, -- window width
            row = 0.5, -- center vertically
            col = 0.5, -- center horizontally
            anchor = 'center', -- anchor point is center
            preview = {
              layout = "horizontal",
              horizontal = "right:50%",
            },
          },
        }
      end,
      desc = 'Fuzzy find files in cwd',
    },
    {
      '<A-g>',
      function()
        require('fzf-lua').live_grep {
          winopts = {
            height = 0.9, -- window height
            width = 0.8, -- window width
            row = 0.5, -- center vertically
            col = 0.5, -- center horizontally
            anchor = 'center', -- anchor point is center
            preview = {
              layout = 'vertical', -- stack preview vertically
              vertical = 'up:50%', -- preview pane at bottom
            },
          },
          glob_flag = '--iglob', -- case sensitive globs
          fzf_opts = {
            ['--layout'] = 'reverse', -- results on top, prompt at bottom
          },
        }
      end,
      desc = 'Grep',
    },
    {
      '<leader>f,',
      function()
        require('fzf-lua').oldfiles()
      end,
      desc = 'Fuzzy find recent files',
    },
    {
      '<leader><leader>',
      function()
        require('fzf-lua').buffers {
          winopts = {
            height = 0.9, -- window height
            width = 0.9, -- window width
            row = 0.5, -- center vertically
            col = 0.5, -- center horizontally
            anchor = 'center', -- anchor point is center
            preview = {
              layout = "horizontal",
              horizontal = "right:50%",
            },
          },
        }
      end,
      desc = 'Find existing buffers',
    },
    {
      '<leader>ro',
      function()
        require('fzf-lua').oldfiles {
          winopts = {
            height = 0.9, -- window height
            width = 0.9, -- window width
            row = 0.5, -- center vertically
            col = 0.5, -- center horizontally
            anchor = 'center', -- anchor point is center
            preview = {
              layout = "horizontal",
              horizontal = "right:50%",
            },
          },
        }
      end,
      desc = 'Recent Files',
    },
    {
      '<leader>kk',
      function()
        require('fzf-lua').keymaps()
      end,
      desc = 'Check keymap availability',
    },
    {
      '<leader>f/',
      function()
        require('fzf-lua').files { cwd = '/', hidden = true }
      end,
      desc = 'Find files in /root',
    },
    {
      '<leader>fh',
      function()
        require('fzf-lua').files { cwd = os.getenv 'HOME', hidden = true }
      end,
      desc = 'Find files in $HOME',
    },
    {
      '<leader>fm',
      function()
        require('fzf-lua').files { cwd = '$HOME/notes' }
      end,
      desc = 'Find files in $HOME/notes',
    },
    {
      '<leader>fM',
      function()
        require('fzf-lua').live_grep_native { cwd = '$HOME/notes' }
      end,
      desc = 'Grep in $HOME/notes',
    },
    {
      '<leader>ce',
      function()
        require('fzf-lua').colorschemes()
      end,
      desc = 'Preview Colorschemes',
    },
    {
      '<leader>fn',
      function()
        require('fzf-lua').files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Find files in Neovim config',
    },
    {
      '<A-/>',
      -- "/",
      function()
        require('fzf-lua').blines {
          winopts = {
            height = 0.9, -- window height
            width = 0.8, -- window width
            row = 0.5, -- center vertically
            col = 0.5, -- center horizontally
            anchor = 'center', -- anchor point is center
            preview = {
              layout = 'vertical', -- stack preview vertically
              vertical = 'up:50%', -- preview pane at bottom
            },
          },
          fzf_opts = {
            ['--layout'] = 'reverse', -- results on top, prompt at bottom
          },
        }
      end,
      desc = 'Fuzzy search in current buffer',
    },
    {
      '<leader>gw',
      function()
        require('fzf-lua').grep_cword()
      end,
      desc = 'Find string in cwd',
    },
    {
      '<A-S-f>',
      function()
        require('fzf-lua').grep_cWORD()
      end,
      desc = 'Find string under cursor in cwd',
    },
    {
      '<leader>fc',
      function()
        require('fzf-lua').grep_cword()
      end,
      desc = 'Find string under cursor in cwd',
    },
    {
      '<leader>cc',
      function()
        require 'neoclip.fzf'()
      end,
      desc = 'Neoclip Clipboard',
    },
    {
      '<leader>gca',
      function()
        require('fzf-lua').git_commits {
          winopts = {
            width = 1.0,
            height = 1.0,
            row = 0.0,
            col = 0.0,
            anchor = 'NW',
          },
        }
      end,
      desc = 'Search Git Commits for cwd',
    },
    {
      '<leader>gcf',
      function()
        require('fzf-lua').git_bcommits {
          winopts = {
            width = 1.0,
            height = 1.0,
            row = 0.0,
            col = 0.0,
            anchor = 'NW',
          },
        }
      end,
      desc = 'Search Git Commits for Current File Only',
    },
    {
      '<leader>fd',
      function()
        require('fzf-lua').diagnostics_workspace()
      end,
      desc = 'Search Diagnostics',
    },
    {
      '<leader>ff',
      function()
        require('fzf-lua').resume()
      end,
      desc = 'Resume last fzf-lua window',
    },
    -- {
    --   "<leader>z",
    --   function()
    --     require("fzf-lua").spell_suggest({
    --       winopts = {
    --         relative = "cursor",
    --         row = 1.01,
    --         col = 0,
    --         width = 0.2,
    --         height = 0.2,
    --       },
    --     })
    --   end,
    --   desc = "Spelling suggestions (Overriden default z=)",
    -- },
    {
      '<leader><tab>',
      function()
        require('fzf-lua').zoxide()
      end,
      desc = 'Zoxide switch b/w cwd',
    },
    {
      '<leader>fq',
      function()
        require('fzf-lua').quickfix()
      end,
      desc = 'Show quick fix list',
    },
    {
      '<leader>fH',
      function()
        require('fzf-lua').help_tags {
          winopts = {
            width = 1.0,
            row = 0.0,
            col = 0.0,
            anchor = 'NW',
            preview = {
              layout = 'vertical',
              vertical = 'up:80%',
            },
          },
        }
      end,
      desc = 'Search Help (Fullscreen)',
    },
    {
      '<leader>ft',
      function()
        require('fzf-lua').grep { cmd = 'rg --column --line-number', search = 'TODO', prompt = 'Todos> ' }
      end,
      desc = 'Find TODOs',
    },
    {
      '<leader>m',
      function()
        require('fzf-lua').marks {
          fzf_opts = {
            ['--query'] = '^', -- Pre-fill input with caret to anchor match at start
          },
        }
      end,
      desc = 'Marks',
    },
  },
}
