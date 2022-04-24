" formatter.vim - Format your code using clang-format
" Tried to convert vim-commentary from TPope. so have no idea about most of
" the vim-foo
" Maintainer:   Furkan Cayci <https://furkan.space/>
" Version:      0.1
" GetLatestVimScripts: 3695 1 :AutoInstall: formatter.vim

if exists("g:loaded_formatter") || v:version < 703
  finish
endif
let g:loaded_formatter = 1

function! s:go(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  elseif a:0 > 1
    let [lnum1, lnum2] = [a:1, a:2]
  else
    let [lnum1, lnum2] = [line("'["), line("']")]
  endif

  execute "silent :!clang-format -i --lines=" . lnum1 . ":" . lnum2 . " " . bufname("%") | redraw!
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
