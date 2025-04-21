return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    {
      '<leader>a',
      '<cmd>Alpha<CR>',
      mode = 'n',
      desc = 'Alpha Dashboard',
    },
  },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- Set header
    dashboard.section.header.val = {
      -- "                                                     ",
      -- "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      -- "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      -- "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      -- "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      -- "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      -- "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      -- "                                                     ",
      '            .        +          .      .          .',
      '     .            _        .                    .',
      '+ ,              /;-._,-.____        ,-----.__',
      '           .    (_:#::_.:::. `-._   /:, /-._, `._,',
      '  `                 \\   _|`"=:_::.`.);  \\ __/ /',
      "        +           ,    `./  \\:. `.   )==-'  .",
      '    .      ., ,-=-.  ,\\, +#./`   \\:.  / /           .',
      ".           \\/:/`-' , ,\\ '` ` `   ): , /_  -o",
      "       .    /:+- - + +- : :- + + -:'  /(o-) \\)     .",
      "  .      ,=':  \\    ` `/` ' , , ,:' `'--\".--\"---._/`7",
      '   `.   (    \\: \\,-._` ` + \'\\, ,"   _,--._,---":.__/',
      "              \\:  `  X` _| _,\\/'   .-'",
      '.               ":._:`\\____  /:\'  /      .           .',
      "                    \\::.  :\\/:'  /              +",
      "   .                 `.:.  /:'  }      .",
      '           .           ):_(:;   \\           .',
      '                      /:. _/ ,  |',
      '                   . (|::.     ,`                  .',
      '     .                |::.    {\\',
      '                      |::.\\  \\ `.',
      '                      |:::(\\    |',
      '              O       |:::/{ }  |                  (o',
      '               )  ___/#\\::`/ (O "==._____   O, (O  /`',
      '          ~~~w/w~"~~,\\` `:/,-(~`"~~~~~~~~"~o~\\~/~w|/~',
      '   ~~~~~~~~~~~~~~~~~~~~~~~~~~~\\\\W~~~~~~~~~~~~\\|/~~',
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button('r', '󱑍  Recent files', ":lua require('fzf-lua').oldfiles()<CR>"),
      dashboard.button('n', '  New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('f', '  Find', ":lua require('fzf-lua').files()<CR>"),
      -- dashboard.button("g", "󰗧  Grep", ":lua require('fzf-lua').live_grep()<CR>"),
      dashboard.button('o', '󰐅  Files', ':OilToggle<CR>'),
      dashboard.button('v', '󰦛  Restore session', ':SessionRestore<CR>'),
      dashboard.button('s', '  Settings', ':e $MYVIMRC | :cd %:p:h | wincmd k | pwd<CR>'),
      dashboard.button('l', '󰒲  Lazy', ':Lazy<CR>'),
      dashboard.button('q', '  Quit', ':qa<CR>'),
    }

    -- Set footer
    --   NOTE: This is currently a feature in my fork of alpha-nvim (opened PR #21, will update snippet if added to main)
    --   To see test this yourself, add the function as a dependecy in packer and uncomment the footer lines
    --   ```init.lua
    --   return require('packer').startup(function()
    --       use 'wbthomason/packer.nvim'
    --       use {
    --           'goolord/alpha-nvim', branch = 'feature/startify-fortune',
    --           requires = {'BlakeJC94/alpha-nvim-fortune'},
    --           config = function() require("config.alpha") end
    --       }
    --   end)
    --   ```
    -- local fortune = require("alpha.fortune")
    -- dashboard.section.footer.val = fortune()

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd [[
				autocmd FileType alpha setlocal nofoldenable
				]]
  end,
}
