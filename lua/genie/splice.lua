----------
-- Used to splice a gene for genie management
-- If already managed nothing will be done.
-- If not managed then the plugin will be installed.
-- @module genie/splice
-- @author samantha-uk
-- @license MIT

local splice = function(gene)
  if (_genie.debug) then
    print(string.format('Called: genie.splice(%s)',vim.inspect(gene[1])))
  end
  assert(type(gene) == 'table', 'genie.splice: requires a table as an argument')
  assert(type(gene[1]) == 'string', 'genie.splice: First element of argument must be a string')
  local geneName = gene[1]

  -- Check to see if gene has previously been spliced by genie
  if (_genie.genes[geneName]) then
    -- Set a flag indicating the gene is still being managed
    _genie.genes[geneName].spliced = true
  else
    _genie.genes[gene[1]] = _genie.git.install(gene)
    _genie.genes[geneName].spliced = true

    -- Save the gene state
    _genie.state.store(_genie.genieConfigFile,_genie.genes)
  end
end

return splice
