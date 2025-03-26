return {
  dir = "/home/dpi0/test/fim.nvim/",
  config = function()
    require("fim").setup({
      opts = {
        width = 0.6,
        height = 0.6,
      },
    })
    -- Helper function for mappings
    local function bind(mode, lhs, rhs, opts)
      opts = opts or { noremap = true, silent = true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    bind("n", "<A-y>", ":FimTerm 1<CR>")
    bind("t", "<A-y>", "<C-\\><C-n>:FimTerm 1<CR>")
    bind("i", "<A-y>", "<Esc>:FimTerm 1<CR>")

    bind("n", "<A-i>", ":FimTerm 2<CR>")
    bind("t", "<A-i>", "<C-\\><C-n>:FimTerm 2<CR>")
    bind("i", "<A-i>", "<Esc>:FimTerm 2<CR>")
  end,
}
