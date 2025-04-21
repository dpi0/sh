return {
  -- dir = "/home/dpi0/test/sip.nvim",
  'dpi0/sip.nvim',
  dependencies = { 'ibhagwan/fzf-lua' },
  -- lazy = false, -- load immediately (optional)
  opts = {
    autoload = false,
  },
  keys = {
    {
      '<leader>sl',
      function()
        -- require("sip").list_sessions()
        require('sip').select()
      end,
      desc = 'Sip: List Sessions',
    },
  },
}

-- return {
--   "rmagatti/auto-session",
--   lazy = false,
--   keys = {
--     -- Will use Telescope if installed or a vim.ui.select picker otherwise
--     { "<leader>sf", "<cmd>SessionSearch<CR>", desc = "Session search" },
--     { "<leader>ss", "<cmd>SessionSave<CR>", desc = "Save session" },
--     { "<leader>sas", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
--     { "<leader>sr", "<cmd>SessionRestore<CR>", desc = "Session Restore" },
--   },
--   ---enables autocomplete for opts
--   ---@module "auto-session"
--   opts = {
--     suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
--     -- log_level = 'debug',
--     enabled = true, -- Enables/disables auto creating, saving and restoring
--     root_dir = vim.fn.stdpath("data") .. "/sessions/", -- Root dir where sessions will be stored
--     auto_save = true, -- Enables/disables auto saving session on exit
--     auto_restore = false, -- Enables/disables auto restoring session on start
--     auto_create = true, -- Enables/disables auto creating new session files. Can take a function that should return true/false if a new session file should be created or not
--     -- suppressed_dirs = nil, -- Suppress session restore/create in certain directories
--     allowed_dirs = nil, -- Allow session restore/create in certain directories
--     auto_restore_last_session = false, -- On startup, loads the last saved session if session for cwd does not exist
--     use_git_branch = false, -- Include git branch name in session name
--     lazy_support = true, -- Automatically detect if Lazy.nvim is being used and wait until Lazy is done to make sure session is restored correctly. Does nothing if Lazy isn't being used. Can be disabled if a problem is suspected or for debugging
--     bypass_save_filetypes = nil, -- List of filetypes to bypass auto save when the only buffer open is one of the file types listed, useful to ignore dashboards
--     close_unsupported_windows = true, -- Close windows that aren't backed by normal file before autosaving a session
--     args_allow_single_directory = true, -- Follow normal sesion save/load logic if launched with a single directory as the only argument
--     args_allow_files_auto_save = false, -- Allow saving a session even when launched with a file argument (or multiple files/dirs). It does not load any existing session first. While you can just set this to true, you probably want to set it to a function that decides when to save a session when launched with file args. See documentation for more detail
--     continue_restore_on_error = true, -- Keep loading the session even if there's an error
--     show_auto_restore_notif = false, -- Whether to show a notification when auto-restoring
--     cwd_change_handling = false, -- Follow cwd changes, saving a session before change and restoring after
--     lsp_stop_on_restore = false, -- Should language servers be stopped when restoring a session. Can also be a function that will be called if set. Not called on autorestore from startup
--     restore_error_handler = nil, -- Called when there's an error restoring. By default, it ignores fold errors otherwise it displays the error and returns false to disable auto_save
--     log_level = "error", -- Sets the log level of the plugin (debug, info, warn, error).
--
--     session_lens = {
--       load_on_setup = true, -- Initialize on startup (requires Telescope)
--       theme_conf = { -- Pass through for Telescope theme options
--         -- layout_config = { -- As one example, can change width/height of picker
--         --   width = 0.8,    -- percent of window
--         --   height = 0.5,
--         -- },
--       },
--       previewer = false, -- File preview for session picker
--
--       mappings = {
--         -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
--         delete_session = { "i", "<C-D>" },
--         alternate_session = { "i", "<C-S>" },
--         copy_session = { "i", "<C-Y>" },
--       },
--
--       session_control = {
--         control_dir = vim.fn.stdpath("data") .. "/auto_session/", -- Auto session control dir, for control files, like alternating between two sessions with session-lens
--         control_filename = "session_control.json", -- File name of the session control file
--       },
--     },
--   },
-- }

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
--     vim.keymap.set("n", "<leader>ss", function()
--       require("persistence").load()
--     end),
--
--     -- select a session to load
--     vim.keymap.set("n", "<leader>sf", function()
--       require("persistence").select()
--     end),
--
--     -- load the last session
--     vim.keymap.set("n", "<leader>sl", function()
--       require("persistence").load({ last = true })
--     end),
--
--     -- stop Persistence => session won't be saved on exit
--     vim.keymap.set("n", "<leader>sx", function()
--       require("persistence").stop()
--     end),
--   },
-- }
