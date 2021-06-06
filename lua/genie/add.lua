----------
-- Used to add a plugin for genie management
-- If already managed nothing will be done.
-- If not managed then the plugin will be installed.
-- @module genie/add
-- @author samantha-uk
-- @license MIT

local M = {}
function M.add(plugin)
  print(string.format('genie.add %s',vim.inspect(plugin)))
end

return M
