-- ===============================
-- Neovim Core Autocmd
-- ===============================

-- ===========================
-- Auto Close All Terminal Buffers on :qa!
-- ===========================
-- Create an augroup for managing terminal buffer closure
vim.api.nvim_create_augroup('TermClose', { clear = true })

-- Set an autocmd for the QuitPre event to close all terminal buffers
vim.api.nvim_create_autocmd('QuitPre', {
  group = 'TermClose',
  callback = function()
    -- Get the list of all buffers
    local bufs = vim.api.nvim_list_bufs()
    -- Iterate through each buffer
    for _, buf in ipairs(bufs) do
      -- Check if the buffer is a terminal buffer using vim.bo[buf]
      if vim.bo[buf].buftype == 'terminal' then
        -- Forcefully delete the terminal buffer
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end,
})

-- ===========================
-- Toggle Autoformat-on-Save
-- ===========================
vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})
vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})

-- ===========================
-- Close Unused Buffers
-- ===========================
local id = vim.api.nvim_create_augroup('startup', {
  clear = false,
})

local persistbuffer = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  vim.fn.setbufvar(bufnr, 'bufpersist', 1)
end

vim.api.nvim_create_autocmd({ 'BufRead' }, {
  group = id,
  pattern = { '*' },
  callback = function()
    vim.api.nvim_create_autocmd({ 'InsertEnter', 'BufModifiedSet' }, {
      buffer = 0,
      once = true,
      callback = function()
        persistbuffer()
      end,
    })
  end,
})

vim.keymap.set('n', '<Leader>cub', function()
  local curbufnr = vim.api.nvim_get_current_buf()
  local buflist = vim.api.nvim_list_bufs()
  for _, bufnr in ipairs(buflist) do
    if vim.bo[bufnr].buflisted and bufnr ~= curbufnr and (vim.fn.getbufvar(bufnr, 'bufpersist') ~= 1) then
      vim.cmd('bd ' .. tostring(bufnr))
    end
  end
end, { silent = true, desc = 'Close unused buffers' })

-- Auto-save current buffer on focus lost
-- Applies to all files/buffers.
-- vim.bo.modified - Checks if the buffer is modified.
-- vim.bo.buftype == "": Ensures it's a normal file (not quickfix, terminal, etc).
-- vim.fn.getbufvar(0, "&readonly") == 0: Prevents saving read-only files.
-- vim.api.nvim_create_autocmd('FocusLost', {
--   pattern = '*',
--   callback = function()
--     if vim.bo.modified and vim.bo.buftype == '' and vim.fn.getbufvar(0, '&readonly') == 0 then
--       vim.cmd 'silent! write'
--     end
--   end,
--   desc = 'Auto-save on losing focus',
--   desc = 'Auto-save on losing focus',
-- })

-- vim.api.nvim_create_autocmd('TextYankPost', {
--   callback = function()
--     local yanked_text = vim.fn.getreg '"'
--     require('yup').add_to_history(yanked_text)
--   end,
-- })
