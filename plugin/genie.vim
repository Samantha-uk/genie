" check to ensure we are running nvim >= 0.5
if !has('nvim-0.5')
  echohl WarningMsg
  echomsg 'nvim >= v0.5 is required to use genie.'
  echohl None
  finish
endif

" Add the genie path to lua packages.path
