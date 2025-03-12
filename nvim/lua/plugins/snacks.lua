return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    indent = {
      enabled = true, --- * out: animate outwards from the cursor
      animate = {
        enabled = vim.fn.has("nvim-0.10") == 1,
        style = "out",
        easing = "linear",
        duration = {
          step = 5, -- ms per step
          total = 200, -- maximum duration
        },
      },
    },
    lazygit = { enabled = true },
  },
  -- stylua: ignore
  keys = {
    { "<A-u>", function() require("snacks").lazygit() end, desc = "Lazygit" },
    { "<leader>lg", function() require("snacks").lazygit.log() end, desc = "Lazygit Logs" },
    { "<leader>rN", function() require("snacks").rename.rename_file() end, desc = "Fast Rename Current File" },
    { "<leader>go", function() require("snacks").gitbrowse() end, desc = "Open current file in the respective GitHub repo" },
    { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>>",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
  }
,
}
