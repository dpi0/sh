return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-ui-select.nvim",
    "folke/todo-comments.nvim",
  },
  keys = {
    -- {
    --   "<A-S-g>",
    --   function()
    --     require("telescope.builtin").live_grep()
    --   end,
    --   desc = "Find string in cwd",
    -- },
    -- {
    --   "<A-S-f>",
    --   function()
    --     require("telescope.builtin").grep_string()
    --   end,
    --   desc = "Find string under cursor in cwd",
    -- },
    -- {
    --   "<leader>fc",
    --   function()
    --     require("telescope.builtin").grep_string()
    --   end,
    --   desc = "Find string under cursor in cwd",
    -- },
    -- {
    --   "<leader>cg",
    --   "<cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>",
    --   desc = "Grep open buffers",
    -- },
    -- {
    --   "<leader>/",
    --   function()
    --     require("telescope.builtin").current_buffer_fuzzy_find(
    --       require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
    --     )
    --   end,
    --   desc = "Fuzzily search in current buffer",
    -- },
    -- {
    --   "<leader>fn",
    --   function()
    --     require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
    --   end,
    --   desc = "Find Neovim files",
    -- },
    -- {
    --   "<leader>fe",
    --   function()
    --     require("telescope.builtin").colorscheme()
    --   end,
    --   desc = "Preview Themes",
    -- },
    -- {
    --   "<leader>fr",
    --   function()
    --     require("telescope.builtin").find_files({ cwd = "/" })
    --   end,
    --   desc = "Find files in /",
    -- },
    -- {
    --   "<leader>fh",
    --   function()
    --     require("telescope.builtin").find_files({ cwd = "/home/dpi0/" })
    --   end,
    --   desc = "Find files in /home/dpi0/",
    -- },
    -- {
    --   "<leader>gs",
    --   function()
    --     require("telescope.builtin").git_status({
    --       previewer = require("telescope.previewers").new_termopen_previewer({
    --         get_command = function(entry)
    --           if entry.status == "??" or entry.status == "A " then
    --             return { "git", "diff", entry.value }
    --           end
    --           return { "git", "diff", entry.value .. "^!" }
    --         end,
    --       }),
    --       layout_strategy = "vertical",
    --     })
    --   end,
    --   desc = "Telescope git status",
    -- },
    -- { "<leader>cc", "<cmd>Telescope neoclip<CR>", desc = "Clipboard" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<A-k>"] = actions.move_selection_previous,
            ["<A-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<esc>"] = actions.close,
          },
        },
      },
      pickers = {
        live_grep = {
          file_ignore_patterns = {
            "node_modules",
            ".venv",
            ".git/objects",
            ".cargo",
            ".cache",
            ".local",
            ".rustup",
            ".mozilla",
            ".continue",
            "vscode",
          },
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
        find_files = {
          file_ignore_patterns = {
            "node_modules",
            ".git/objects",
            ".venv",
            ".cargo",
            ".cache",
            ".local",
            ".rustup",
            ".mozilla",
            ".continue",
            "vscode",
          },
          hidden = true,
        },
      },
      extensions = {
        ["ui-select"] = require("telescope.themes").get_dropdown(),
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")

    -- Custom buffer delete binding (not part of keys[])
    vim.keymap.set("n", "<C-w>", function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end)
  end,
}
