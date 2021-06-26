------------
--- Save the genie state as a loadable lua file.
-- @module genie/util/state
-- @author samantha-uk
-- @license MIT
-- Inspired by https://github.com/hipe/lua-table-persistence

local M = {}

-- Store state in filename as a lua table.
function M.store(filename, state)
  assert(type(filename) == 'string', 'genie.util.state.store: Filename must be a string')
  local file, err = io.open(filename, 'w+')
  if (not file) then
    print(string.format('Error in genie.util.state.store: %s', err))
  end
  file:write('-- File generated by genie\n')
  file:write('return ')

  M.write(file, state, 1)

  file:close()
end

-- Load state from filename as a lua table and execute it.
function M.load(filename)
  local genes = nil

  local geneState = loadfile(filename)

  if (geneState) then
    genes = geneState()
  end

  return genes or {}
end

function M.write(file, item, level)
	M.writers[type(item)](file, item, level)
end

-- Format items for the purpose of restoring
M.writers = {
	["number"] = function (file, item, _)
			file:write(tostring(item) .. ',')
		end,

	["string"] = function (file, item, _)
	    file:write(string.format("%q", item) .. ',')
	  end,

	["boolean"] = function (file, item, _)
      file:write(tostring(item), ',')
		end,

	["table"] = function (file, item, level)
		  file:write('{\n')
		  for k, v in pairs(item) do
        file:write(string.sub('          ', 1, level*2))
				file:write('["' .. k .. '"] =')
				M.write(file, v, level+1)
				file:write('\n')
			end
      file:write(string.sub('          ', 1, level*2))
      file:write('}')
      if (level > 1) then
        file:write(',')
      end
      file:write('\n')
  end
}

return M
