# Genie 
A lua based package/plugin manager for Neovim

Genie is a little different from most nvim package/plugin managers.

Genie's primary aim is to ensure that any managed packages/plugins (Hereafter referred to as genes) are downloaded, installed and initalised at the start of running Neovim.  It does not use async processes to do this.

The result is that after adding a gene to your configuration, the next time you launch Neovim, at the end of startup the gene will be there and ready to use ... no need to run any genie commands.

The use case that drove this approach was to encapsulate all the configuration of a gene in a single place in the configuration (See [ChimeraVim](https://github.com/Samantha-uk/chimeraVim) for an example) 
