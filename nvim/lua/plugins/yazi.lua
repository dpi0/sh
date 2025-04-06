return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<A-m>",
      "<cmd>Yazi toggle<CR>",
      mode = "n",
      desc = "Toggle Yazi file manager (normal)",
    },
    {
      "<A-m>",
      "<C-\\><C-n><cmd>Yazi toggle<CR>",
      mode = "t",
      desc = "Toggle Yazi file manager (terminal)",
    },
  },
}
