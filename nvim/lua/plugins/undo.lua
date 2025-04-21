-- return {
--   "debugloop/telescope-undo.nvim",
--   dependencies = { -- note how they're inverted to above example
--     {
--       "nvim-telescope/telescope.nvim",
--       dependencies = { "nvim-lua/plenary.nvim" },
--     },
--   },
--   keys = {
--     { -- lazy style key map
--       "<leader>u",
--       "<cmd>Telescope undo<cr>",
--       desc = "undo history",
--     },
--   },
--   opts = {
--     extensions = {
--       undo = {
--         side_by_side = true,
--         layout_strategy = "vertical",
--         layout_config = {
--           preview_height = 0.6,
--         },
--       },
--     },
--   },
--   config = function(_, opts)
--     -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
--     -- configs for us. We won't use data, as everything is in it's own namespace (telescope
--     -- defaults, as well as each extension).
--     require("telescope").setup(opts)
--     require("telescope").load_extension("undo")
--   end,
-- }

return {
  'mbbill/undotree',
  keys = {
    {
      '<leader>u',
      '<cmd>UndotreeToggle<CR>',
      desc = 'Toggle UndoTree',
    },
    -- {
    --   "<leader>U",
    --   function()
    --     vim.cmd("UndotreeShow")
    --     vim.cmd("UndotreeFocus")
    --   end,
    --   desc = "Show and focus UndoTree",
    -- },
  },
  init = function()
    -- Optional: Customize behavior
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_WindowLayout = 2 -- [2] = tree on left, diff on right
    vim.g.undotree_SplitWidth = 40 -- Width of the undotree split
    vim.g.undotree_DiffAutoOpen = 1 -- Auto open diff panel
    vim.g.undotree_HelpLine = 0 -- Disable help line at bottom
  end,
  cmd = { 'UndotreeToggle', 'UndotreeShow', 'UndotreeHide', 'UndotreeFocus' },
}
