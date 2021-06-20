--- genie plugin manager health check
-- @module autoload/health/genie.lua
-- @author samantha-uk
-- @license MIT
print('Loaded: autoload/health/genie.lua')
vim.api.nvim_exec(
[[
function! health#genie#check()
  echom 'genie vim healthcheck'
endfunction
]],
false)

