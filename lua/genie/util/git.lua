------------
-- @module genie/util/git
-- @author samantha-uk
-- @license MIT

local M = {}

-- Setup the git commands
local git = {
  clone = 'git clone --depth=1 %s %s %s',
  pull = 'git -C %s pull',
}

function M.install(gene)
  if (_genie.debug) then
    print(string.format('Called: genie/util/git.install(%s)',vim.inspect(gene)))
  end
  -- Is it a start or opt package
  local startOrOpt = 'opt' -- the default

  -- Split the package name into parts based on git naming convention
  local packageNameParts = vim.split(gene[1],'/',true)

  -- The package must consist of two parts
  assert((#packageNameParts == 2), 'genie.git.install: Malformed gene name')

  -- Construct the local package installation path
  local packagePath = string.format(_genie.packagePathFormat, startOrOpt, packageNameParts[#packageNameParts])

  -- Remove the packagePath, do not complain if it does not exist.
  _genie.os.rmdir(packagePath)

  -- Construct the full git repo URL
  local repoURL = string.format('https://github.com/%s',gene[1])

  -- Configure branch if specified
  local branch = ''
  local has_branch = gene.branch or false
  if (has_branch) then
    branch = '--branch ' .. gene.branch
  end

  -- Perform a git clone
  vim.fn.system(string.format(git.clone, branch, repoURL, packagePath))
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
-- Update the plugin using git pull
function M.update(gene)
  -- Perform a git clone
  vim.fn.system(string.format(git.pull, gene.packagePath))
  local result = vim.v.shell_error
  assert(result == 0, string.format('Failed to update [%s] %s',gene.packageName, result))
end

return M
