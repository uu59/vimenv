" /* vim: set fdm=marker: */

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

set lines=40
set columns=130

if has('unix') && !has('mac')
  set guifont=VLGothic\ 10
  set guifontwide=VLGothic\ 10
  set linespace=0
endif

if has('mac')
  "set guifontwide=MotoyaLCedar\ 9
  set guifont=Osaka−等幅:h14
  set linespace=1
  "MacVim can't read if has('gui_running') in .vimrc :(
  " colo herokudoc 
  colo dracula
  if has('gui_running')
    set transparency=10
    set lines=75
    set columns=240
  endif
endif

set novb
set noballooneval

" syntastic color setting
hi SyntasticErrorSign guibg=#ff6666 guifg=#000000
hi SyntasticWarningSign guibg=#ffff99 guifg=#000000

" -- fix $PATH {{{
" gvimで$PATHがzshrcの定義と違う（nodebrewやrbenvのPATHが通ってない）
" ので必要に応じてsystemのPATHを再セットする

if has('unix') && !has('mac')
  if has('vim_starting')
    let $PATH=system('echo $PATH')
  endif
endif
" }}}
