" Title: Picker Plugin
" Description: Picks lines matching pattern into a new buffer
" Last Changed: 17 September 2023
" Maintainer: Suzhan Yu <https://github.com/suzhanyu>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded 
" variable and continue running this instance of the plugin.
if exists("g:loaded_pickerplugin")
  finish
endif
let g:loaded_pickerplugin = 1

command! -nargs=1 Pick call Pick(<q-args>) 

function! Pick(p)
  let @c=''
  execute 'g/' . a:p . '/y C'
  if getreg('c') == ''
    return
  endif
  let l:name = Generate_result_file_name()
  new
  norm! "cp
  norm! gg

  " delete until the first non-blank line
  exe 'g/^$/d'
  execute 'w ' . l:name
endfunction

function! Generate_result_file_name()
  let file = expand('%:p')
  let dir = matchstr(file, '.*\/')
  let files_str = globpath(dir, '*')
  let files = split(files_str)
  let l:largest = 0
  for result in files
    let l:num = str2nr(matchstr(result, '\v(picker-result-)@<=\d+'))
    if l:num > l:largest
      let l:largest = num
    endif
  endfor
  let l:largest = l:largest + 1
  return 'picker-result-' . l:largest . '.txt'
endfunction
