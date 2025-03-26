-- return {
--   "ackeraa/todo.nvim",
--   config = function()
--     local home = os.getenv("HOME")
--     require("todo").setup({
--       opts = {
--         file_path = home .. "/todo.txt",
--       },
--     })
--   end,
-- }

return {
  "ntocampos/todone.nvim",
  dependencies = {
    -- Either one or the other
    -- { "nvim-telescope/telescope.nvim", optional = true },
    { "folke/snacks.nvim", optional = true },
  },
  opts = {
    root_dir = "~/todone/",
    float_position = "topright",
  },
  keys = {
    { "<leader>tt", "<cmd>TodoneToday<cr>", desc = "Open today's notes" },
    { "<leader>tf", "<cmd>TodoneToggleFloat<cr>", desc = "Toggle priority float" },
    -- The commands below require a picker
    { "<leader>tl", "<cmd>TodoneList<cr>", desc = "List all notes" },
    { "<leader>tg", "<cmd>TodoneGrep<cr>", desc = "Search inside all notes" },
    { "<leader>tp", "<cmd>TodonePending<cr>", desc = "List notes with pending tasks" },
  },
}
