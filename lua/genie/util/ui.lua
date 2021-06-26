------------
---  UI routines for genie
-- @module genie/util/ui
-- @author samantha-uk
-- @license MIT

local M = {}

function M.get_window()
  local bufnr = vim.api.nvim_create_buf(false, false)
  vim.api.nvim_buf_set_option(bufnr, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(bufnr, 'swapfile', false)
  vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(bufnr, 'filetype', 'genie')
  vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
  return bufnr
end

return M
