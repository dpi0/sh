return {
  'AckslD/nvim-neoclip.lua',
  lazy = true,
  dependencies = {
    { 'kkharji/sqlite.lua', module = 'sqlite' },
    -- you'll need at least one of these
    -- {'nvim-telescope/telescope.nvim'},
    -- {'ibhagwan/fzf-lua'},
  },
  config = function()
    local function is_whitespace(line)
      return vim.fn.match(line, [[^\s*$]]) ~= -1
    end
    local function all(tbl, check)
      for _, entry in ipairs(tbl) do
        if not check(entry) then
          return false
        end
      end
      return true
    end
    require('neoclip').setup {
      -- the following lines set up so clips are stored from session to session
      history = 1000,
      enable_persistent_history = true,
      -- To clear all entries from the sqlite3 database run
      -- :lua require('neoclip').clear_history()
      length_limit = 1048576,
      continuous_sync = false,
      db_path = vim.fn.stdpath 'data' .. '/databases/neoclip.sqlite3',
      -- don't store entries that are all whitespace - see fns above
      filter = function(data)
        return not all(data.event.regcontents, is_whitespace)
      end,
      keys = {
        telescope = {
          i = {
            select = '<cr>',
            paste = '<Enter>',
            paste_behind = '<c-k>',
            replay = '<c-q>', -- replay a macro
            delete = '<c-d>', -- delete an entry
            edit = '<c-e>', -- edit an entry
            custom = {},
          },
          n = {
            select = '<cr>',
            paste = 'p',
            --- It is possible to map to more than one key.
            -- paste = { 'p', '<c-p>' },
            paste_behind = 'P',
            replay = 'q',
            delete = 'd',
            edit = 'e',
            custom = {},
          },
        },
        fzf = {
          select = 'default',
          paste = 'Enter',
          paste_behind = 'ctrl-k',
          custom = {},
        },
      },
    }
  end,
}
