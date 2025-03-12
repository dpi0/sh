return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { "<leader>sf", "<cmd>SessionSearch<CR>", desc = "Session search" },
    { "<leader>ss", "<cmd>SessionSave<CR>", desc = "Save session" },
    { "<leader>sas", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
    { "<leader>sr", "<cmd>SessionRestore<CR>", desc = "Session Restore" },
  },
  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    -- log_level = 'debug',
  },
}

-- return {
--   "folke/persistence.nvim",
--   event = "BufReadPre", -- this will only start session saving when an actual file was opened
--   opts = {
--     dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
--     -- minimum number of file buffers that need to be open to save
--     -- Set to 0 to always save
--     need = 1,
--     branch = true, -- use git branch to save session
--   },
--   keys = {
--     -- load the session for the current directory
--     vim.keymap.set("n", "<leader>qs", function()
--       require("persistence").load()
--     end),
--
--     -- select a session to load
--     vim.keymap.set("n", "<leader>qS", function()
--       require("persistence").select()
--     end),
--
--     -- load the last session
--     vim.keymap.set("n", "<leader>ql", function()
--       require("persistence").load({ last = true })
--     end),
--
--     -- stop Persistence => session won't be saved on exit
--     vim.keymap.set("n", "<leader>qd", function()
--       require("persistence").stop()
--     end),
--   },
-- }
