------------
-- @module genie/util/git
-- @author samantha-uk
-- @license MIT

local M = {}

function M.install(package)
  if (_genie.debug) then
    print(string.format('Called: genie/util/git.install(%s)',vim.inspect(package)))
  end
  -- Is it a start or opt package
  local startOrOpt = 'opt' -- the default
  -- if (package.opt) then
  --   startOrOpt = 'opt'
  -- end

  -- Split the package name
  local packageNameParts = vim.split(package[1],'/',true)

  -- The package must consist of at least two parts
  assert(#packageNameParts > 1, 'genie.git.install: Unrecognised package name')

  -- Construct the local package installation path
  local packagePath = string.format(_genie.packagePathFormat, startOrOpt, packageNameParts[#packageNameParts])

  -- Remove the packagePath, do not complain if it does not exist.
  _genie.os.rmdir(packagePath)

  -- Construct the full git repo URL
  local repoURL = string.format('https://github.com/%s',package[1])

  -- Perform a git clone
  vim.fn.system(string.format('git clone --depth=1 %s %s', repoURL, packagePath))
  local result = vim.v.shell_error

  -- Return the status information
  local status = {}
  status.repoURL = repoURL
  status.packagePath = packagePath
  status.packageName = packageNameParts[#packageNameParts]

  if (result == 0) then
    status.installed = true
  else
    status.installed = false
    status.failureReason = result
  end
  return status
end

-- function M.uninstall()
-- end
--
-- function M.needsUpdate()
-- end
return M
