" pakal load script
" check to ensure we are running nvim >= 0.5
echomsg 'starting genie.vim'
if !has('nvim-0.5')
  echohl WarningMsg
  echomsg 'nvim 0.5 is required to use genie.'
  echohl None
  finish
endif

" Only do initalisation once
if exists('g:isGenieInitialised')
  echomsg 'Genie is already initalised'
  finish
endif

lua << end
print('Initalising genie...')
require('genie').initalise()
print('Finished Initalising genie.')
end

let g:isGenieInitialised=1
