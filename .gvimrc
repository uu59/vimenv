"let g:molokai_original = 1
"colo magica
"colo molokai
"colo lucius
"colo blackdust
"colo xoria256
"colo vilight
"colo github
set guioptions=-rLbc
"set guifont=VL\ ゴシック\ 9
"set guifont=Inconsolata\ Medium\ 9
"set guifontwide=VL\ ゴシック\ 9
"set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
"set guifontwide=Takao\ ゴシック\ 9
"set guifont=DejaVu\ Sans\ Mono\ 11
"set guifontwide=MotoyaLCedar\ 11

if has('unix') && !has('mac')
  set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
  set guifontwide=VLGothic\ 10
  set linespace=0
endif

if has('mac')
  "set guifontwide=MotoyaLCedar\ 9
  set guifont=Osaka−等幅:h14
  set linespace=1
  colo herokudoc "MacVim can't read if has('gui_running') in .vimrc :(
endif

set novb
set lines=40
set columns=130

" for vimshell on gvim
if has('unix') && !has('mac')
  let $PATH=system('echo $PATH')
endif
