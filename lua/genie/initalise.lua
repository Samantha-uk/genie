------------
-- Initialisation code for genie
-- @module genie/init
-- @author samantha-uk
-- @license MIT
print('starting genie/initalise.lua')
-- Create pakal global variable
_G._genie = _G._genie or {}

-- Setup the pakal modules
_G._genie.add = require('genie').add()
_G._genie.clean = require('genie').clean()
_G._genie.congfig = require('genie').config()
_G._genie.remove = require('genie').remove()
_G._genie.status = require('genie').status()
_G._genie.update = require('genie').update()
print(vim.inspect(_G._pakal))
-- Setup commands
vim.cmd [[command! GenieAdd lua = _G._genie.add()]]
vim.cmd [[command! GenieClean lua = _G._genie.clean()]]
vim.cmd [[command! GenieRemove lua = _G._genie.remove()]]
vim.cmd [[command! GenieStatus lua = _G._genie.status()]]
vim.cmd [[command! GenieUpdate lua = _G._genie.update()]]

-- Protect against typos when using pakal global variable
setmetatable(_G, {
  __index = function (_, n)
    error("attempt to use an undeclared genie item "..n, 2)
  end,
})

print('ending pakal/initalise.lua')
return _G._pakal
