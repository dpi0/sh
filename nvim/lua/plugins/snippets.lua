return {
  'L3MON4D3/LuaSnip',
  -- follow latest release.
  version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = 'make install_jsregexp',
  config = function()
    local luasnip = require 'luasnip'

    local s = luasnip.snippet
    local t = luasnip.text_node
    local i = luasnip.insert_node

    local hello = s('hello', {
      t 'Hello ',
      i(1, 'world'),
    })

    local foo = s('bar', t 'baz')

    luasnip.add_snippets('all', { foo })
    luasnip.add_snippets('all', { hello })

    luasnip.config.set_config {
      enable_autosnippets = true,
    }

    local hi = s({
      trig = 'hi',
      snippetType = 'autosnippet',
    }, {
      t 'Hello ',
      i(1, 'world'),
    })

    luasnip.add_snippets('all', { hi })

    vim.keymap.set({ 'i', 's' }, '<C-S-l>', function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { desc = 'Snippet next argument', silent = true })

    vim.keymap.set({ 'i', 's' }, '<C-S-h>', function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { desc = 'Snippet previous argument', silent = true })
  end,
}
