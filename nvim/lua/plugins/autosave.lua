return {
  'okuuva/auto-save.nvim',
  cmd = 'ASToggle',                                                          -- optional for lazy loading on command
  event = { 'InsertLeave', 'TextChanged' },                                  -- optional for lazy loading on trigger events
  opts = {
    trigger_events = {                                                       -- See :h events
      immediate_save = { 'BufLeave', 'FocusLost', 'QuitPre', 'VimSuspend' }, -- vim events that trigger an immediate save
      -- defer_save = { 'InsertLeave', 'TextChanged' },                         -- vim events that trigger a deferred save (saves after `debounce_delay`)
      defer_save = { 'FocusLost' },                                          -- vim events that trigger a deferred save (saves after `debounce_delay`)
      cancel_deferred_save = { 'InsertEnter' },                              -- vim events that cancel a pending deferred save
    },
    write_all_buffers = false,                                               -- write all buffers when the current one meets `condition`
    debounce_delay = 1000,                                                   -- delay after which a pending save is executed
  },
  keys = {
    {
      '<leader>A',
      ':ASToggle<CR>',
      desc = 'Toggle Auto Save',
    },
  },
}
