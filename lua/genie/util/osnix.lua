------------
--- *nix commands
-- @module genie/util/osnix
-- @author samantha-uk
-- @license MIT

local M = {}

function M.rmdir(path)
  return os.execute('rm --dir --recursive --force "'.. path ..'"')
end

return M
