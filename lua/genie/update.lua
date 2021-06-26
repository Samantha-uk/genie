------------
--- Updates all genie managed genes.
-- @module genie/update
-- @author samantha-uk
-- @license MIT

local update = function()
  if (_genie.debug) then
    print('Called: genie.update()')
  end
  for name, config in pairs(_genie.genes) do
    print ('[' .. name .. ']')
    _genie.git.update(config)
  end
end

return update
