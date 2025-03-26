---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  -- dependencies = { "folke/snacks.nvim", lazy = true },
  -- keys = {
  -- 👇 in this section, choose your own keymappings!
  -- {
  --   "<A-m>",
  --   mode = { "n", "v" },
  --   "<cmd>Yazi<cr>",
  --   desc = "Open yazi at the current file",
  -- },
  -- {
  --   -- Open in the current working directory
  --   "<leader>cw",
  --   "<cmd>Yazi cwd<cr>",
  --   desc = "Open the file manager in nvim's working directory",
  -- },
  -- {
  --   "<A-m>",
  --   "<cmd>Yazi toggle<cr>",
  --   desc = "Resume the last yazi session",
  -- },
  -- },
  -- ---@type YaziConfig | {}
  -- opts = {
  --   -- if you want to open yazi instead of netrw, see below for more info
  --   open_for_directories = false,
  --   keymaps = {
  --     show_help = "<f1>",
  --   },
  -- },
  -- -- 👇 if you use `open_for_directories=true`, this is recommended
  -- init = function()
  --   -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
  --   -- vim.g.loaded_netrw = 1
  --   vim.g.loaded_netrwPlugin = 1
  -- end,
  config = function()
    -- Helper function for mappings
    local function bind(mode, lhs, rhs, opts)
      opts = opts or { noremap = true, silent = true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    bind("n", "<A-m>", "<cmd>Yazi toggle<CR>")
    bind("t", "<A-m>", "<C-\\><C-n><cmd>Yazi toggle<CR>")
  end,
}
