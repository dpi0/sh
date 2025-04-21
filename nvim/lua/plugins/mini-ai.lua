return {
  -- {
  --   "echasnovski/mini.indentscope",
  --   version = "*",
  --   config = function()
  --     require("mini.indentscope").setup({
  --       symbol = "╎",
  --
  --       -- Draw options
  --       draw = {
  --         -- Delay (in ms) between event and start of drawing scope indicator
  --         delay = 50,
  --
  --         -- Animation rule for scope's first drawing. A function which, given
  --         -- next and total step numbers, returns wait time (in ms). See
  --         -- |MiniIndentscope.gen_animation| for builtin options. To disable
  --         -- animation, use `require('mini.indentscope').gen_animation.none()`.
  --         -- animation = --<function: implements constant 20ms between steps>,
  --
  --         -- Whether to auto draw scope: return `true` to draw, `false` otherwise.
  --         -- Default draws only fully computed scope (see `options.n_lines`).
  --         -- predicate = function(scope) return not scope.body.is_incomplete end,
  --
  --         -- Symbol priority. Increase to display on top of more symbols.
  --         -- priority = 2,
  --       },
  --     })
  --   end,
  -- },
  {
    'echasnovski/mini.ai',
    version = '*',
    config = function()
      require('mini.ai').setup()
    end,
  },
}
