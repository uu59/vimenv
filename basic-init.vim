" /* vim: set fdm=marker: */

set nocompatible

if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = $HOME . '/.config'
endif
let $VIM_CONFIG_DIR=$XDG_CONFIG_HOME . '/vim'

set runtimepath=$VIM_CONFIG_DIR,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME

if !exists('g:tinyvim')
  let g:tinyvim = 1
endif

if has("gui_running")
  source $XDG_CONFIG_HOME/vim/gvim.vim
endif

source $XDG_CONFIG_HOME/vim/plug.vim
