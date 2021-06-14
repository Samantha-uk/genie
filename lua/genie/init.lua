------------
--- Initalise genie.
-- @module genie/init
-- @author samantha-uk
-- @license MIT
-- Create genie global variable
_genie = _genie or {}

_genie.debug = false;

if (_genie.debug) then
  print('Loaded: genie/init.lua')
end

-- Setup the genie modules
_genie.splice = require('genie.splice')
_genie.git = require('genie.util.git')
_genie.state = require('genie.util.state')

-- Setup OS specific stuff
_genie.pathSeparator = package.config:sub(1,1)
if (jit.os == "Windows") then
  _genie.os = require('genie.util.oswin')
else
  _genie.os = require('genie.util.osnix')
end

-- Create a format string (using OS specific seperators) to be used when accessing local paths
_genie.packagePathFormat = table.concat({vim.fn.stdpath('data'), 'site', 'pack','genie','%s','%s'}, _genie.pathSeparator)

-- Build the filename for the genie state file
_genie.genieStateFile = table.concat({vim.fn.stdpath('config'), 'genie','state.lua'}, _genie.pathSeparator)

-- Read the gene state from disk
local genes  = loadfile(_genie.genieStateFile)
if (genes) then
  _genie.genes = genes()
else
  _genie.genes = {}
end

-- Setup commands
vim.cmd [[command! GenieClean lua require('genie.clean')()]]
vim.cmd [[command! GenieRemove lua require('genie.remove')()]]
vim.cmd [[command! GenieStatus lua require('genie.status')()]]
vim.cmd [[command! GenieUpdate lua require('genie.update')()]]

-- Protect against typos when using _genie
setmetatable(_genie, {
  __newindex = function (_, n)
    error('Adding a new genie item is not allowed '..n, 2)
  end,
  __index = function (_, n)
    error('Attempt to use an undeclared genie item '..n, 2)
  end,
})
return _genie

-- TODO: Lazy load everything into plenary.
-- local plenary = setmetatable({}, {
--   __index = function(t, k)
--     local ok, val = pcall(require, string.format('plenary.%s', k))
--
--     if ok then
--       rawset(t, k, val)
--     end
--
--     return val
--   end
-- })
--
-- return plenary
