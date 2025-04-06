return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    previewers = {
      builtin = {
        syntax_limit_b = 1024 * 100, -- 100KB limit on previews.
      },
    },
    grep = {
      rg_glob = true, -- enable glob parsing
      glob_flag = "--iglob", -- case insensitive globs
      glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
      rg_opts = table.concat({
        "--hidden", -- if you want to include hidden files (optional)
        "--no-ignore-vcs", -- optional, to ignore .gitignore
        "--glob=!**/.local/**",
        "--glob=!**/.rustup/**",
        "--glob=!**/node_modules/**",
        "--glob=!**/.cargo/**",
        "--glob=!**/.continue/**",
        "--glob=!**/.mozilla/**",
        "--glob=!**/go/pkg/mod/**",
        "--glob=!**/Code/User/**",
        "--glob=!**/.git/**",
        "--glob=!**/.npm/**",
        "--glob=!**/.cache/**",
      }, " "),
    },
    files = {
      cmd = table.concat({
        "fd --type f --hidden --follow",
        "--exclude .git",
        "--exclude node_modules",
        "--exclude .cargo",
        "--exclude .mozilla",
        "--exclude .cache",
        "--exclude .npm",
        "--exclude .rustup",
        "--exclude go/pkg/mod",
        "--exclude Code/User",
        "--exclude .local",
        "--exclude .continue",
      }, " "),
    },
  },
  keys = {
    {
      "<leader>fzf",
      function()
        vim.cmd("FzfLua")
      end,
      desc = "FzfLua ❤️",
    },
    {
      "<A-f>",
      function()
        require("fzf-lua").files()
      end,
      desc = "Fuzzy find files in cwd",
    },
    {
      "<A-g>",
      function()
        require("fzf-lua").live_grep({
          winopts = {
            height = 0.9, -- window height
            width = 0.8, -- window width
            row = 0.5, -- center vertically
            col = 0.5, -- center horizontally
            anchor = "center", -- anchor point is center
            preview = {
              layout = "vertical", -- stack preview vertically
              vertical = "up:50%", -- preview pane at bottom
            },
          },
          fzf_opts = {
            ["--layout"] = "reverse", -- results on top, prompt at bottom
          },
        })
      end,
      desc = "Find string in cwd",
    },
    {
      "<leader>f,",
      function()
        require("fzf-lua").oldfiles()
      end,
      desc = "Fuzzy find recent files",
    },
    {
      "<leader><leader>",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "Find existing buffers",
    },
    {
      "<leader>ro",
      function()
        require("fzf-lua").oldfiles()
      end,
      desc = "Recent Files",
    },
    {
      "<leader>kk",
      function()
        require("fzf-lua").keymaps()
      end,
      desc = "Check keymap availability",
    },
    {
      "<leader>f/",
      function()
        require("fzf-lua").files({ cwd = "/", hidden = true })
      end,
      desc = "Find files in /root",
    },
    {
      "<leader>fh",
      function()
        require("fzf-lua").files({ cwd = os.getenv("HOME"), hidden = true })
      end,
      desc = "Find files in $HOME",
    },
    {
      "<leader>ce",
      function()
        require("fzf-lua").colorschemes()
      end,
      desc = "Preview Colorschemes",
    },
    {
      "<leader>fn",
      function()
        require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find files in Neovim config",
    },
    {
      "<A-/>",
      -- "/",
      function()
        require("fzf-lua").blines()
      end,
      desc = "Fuzzy search in current buffer",
    },
    {
      "<A-S-g>",
      function()
        require("fzf-lua").grep_cword()
      end,
      desc = "Find string in cwd",
    },
    {
      "<A-S-f>",
      function()
        require("fzf-lua").grep_cWORD()
      end,
      desc = "Find string under cursor in cwd",
    },
    {
      "<leader>fc",
      function()
        require("fzf-lua").grep_cword()
      end,
      desc = "Find string under cursor in cwd",
    },
    {
      "<leader>cc",
      function()
        require("neoclip.fzf")()
      end,
      desc = "Neoclip Clipboard",
    },
  },
}
