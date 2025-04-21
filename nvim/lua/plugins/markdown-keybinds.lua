return {
  'antonk52/markdowny.nvim',
  event = 'VeryLazy',
  config = function()
    require('markdowny').setup()
  end,
}
