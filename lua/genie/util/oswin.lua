------------
--- Windows commands
-- @module genie/util/oswin
-- @author samantha-uk
-- @license MIT

local M = {}

function M.rmdir(path)
  return os.execute('rmdir /Q /S "'.. path ..'"')
end

return M
