--- Used to splice a gene for genie management
-- If already managed nothing will be done.
-- If not managed then the plugin will be installed.
-- @module genie/splice
-- @author samantha-uk
-- @license MIT

local splice = function(gene)
  if (_genie.debug) then
    print(string.format('Called: genie.splice(%s)',vim.inspect(gene[1])))
  end

  assert(type(gene) == 'table', 'genie.splice(): requires a table as an argument')
  assert(type(gene[1]) == 'string', 'genie.splice(): First element of argument must be a string')
  local geneName = gene[1]

  gene.load = gene.load or false

  -- Check to see if gene has previously been spliced and thus in our 'managed' set of genes
  if (_genie.genes[geneName]) then
    -- Set a flag indicating the gene is still being managed
    _genie.genes[geneName].spliced = true
  else
    _genie.genes[gene[1]] = _genie.git.install(gene)
    -- TODO: Add error handling
    _genie.genes[geneName].spliced = true

    -- Save the gene state to disk
    _genie.state.store(_genie.genieStateFile, _genie.genes)
  end

  if (gene.load) then
    if (_genie.debug) then
      print('Calling packadd [' .. _genie.genes[geneName].packageName .. ']')
    end
    vim.cmd ('packadd ' .. _genie.genes[geneName].packageName)
  end
end

return splice
