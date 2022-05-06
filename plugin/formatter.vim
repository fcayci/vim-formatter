" vim-formatter.vim - Format your code using clang-format
" Based on vim-commentary by TPope
"
" Maintainer:   Furkan Cayci <https://furkan.space/>
" Version:      0.2

if exists("g:loaded_vim_formatter") || v:version < 703
  finish
endif
let g:loaded_vim_formatter = 1

function! s:go(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  elseif a:0 > 1
    let [lnum1, lnum2] = [a:1, a:2]
  else
    let [lnum1, lnum2] = [line("'["), line("']")]
  endif

  execute ":" . lnum1 . "," . lnum2 . "!clang-format"
endfunction

command! -range -bar -bang Formatter call s:go(<line1>,<line2>,<bang>0)
xnoremap <expr>   <Plug>Formatter     <SID>go()
nnoremap <expr>   <Plug>Formatter     <SID>go()

if !hasmapto('<Plug>Formatter') || maparg('gp','n') ==# ''
  xmap gp  <Plug>Formatter
  nmap gp  <Plug>Formatter
  omap gp  <Plug>Formatter
endif

" vim:set et sw=2:
