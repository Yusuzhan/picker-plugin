" Title: Picker Plugin
" Description: Picks lines matching pattern into a new buffer
" Last Changed: 15 September 2023
" Maintainer: Suzhan Yu <https://github.com/suzhanyu>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded 
" variable and continue running this instance of the plugin.
if exists("g:loaded_pickerplugin")
  finish
endif
let g:loaded_pickerplugin = 1

command! -nargs=1 Pick call Pick(<q-args>) 
command! -nargs=0 Foo call Foo() 

function! Pick(p)
  let @c=''
  execute 'g/' . a:p . '/y C'
  new
  norm! "cp
  norm! gg

  " delete until the first non-blank line
  exe 'g/^$/d'
  echom expand('%:p')
  let name = 'result' . strftime('%Y-%m-%dT%H:%M:%S')
  execute 'w ' . l:name
endfunction

function! Foo()
  exe 'g/^$/d'
endfunction
