let g:molokai_original = 1
colo molokai
set guioptions=-rLbc
"set guifont=VL\ ゴシック\ 9
"set guifont=Inconsolata\ Medium\ 9
"set guifontwide=VL\ ゴシック\ 9
if has('unix') && !has('mac')
  set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
  set guifontwide=MotoyaLCedar\ 9
endif
if has('mac')
  "set guifontwide=MotoyaLCedar\ 9
  set guifont=Osaka−等幅:h14
endif
set linespace=1
set novb
set lines=40
set columns=130
