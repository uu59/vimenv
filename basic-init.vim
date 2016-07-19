" /* vim: set fdm=marker: */

set nocompatible

if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = $HOME . '/.config'
endif
let $VIM_CONFIG_DIR=$XDG_CONFIG_HOME . '/vim'

set runtimepath=$VIM_CONFIG_DIR,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME
" for tmux: http://stackoverflow.com/a/15095377
set t_ut=

if !exists('g:tinyvim')
  let g:tinyvim = 1
endif

if has("gui_running")
  source $XDG_CONFIG_HOME/vim/gvim.vim
endif

source $XDG_CONFIG_HOME/vim/plug.vim

" ### set variables ### {{{
set nrformats=hex " ignore octal incr/decr
set showmatch
set matchtime=0
set ambiwidth=double
set mouse=
set history=10000
set notitle
set titlestring=%F%(\ %M%)%(\ (%{getcwd()})%)%(\ %a%)
set completeopt=menuone,preview
set lazyredraw
set expandtab
set ts=2 sw=2
set incsearch
set ignorecase
set smartcase
set autoindent
set nowrap
set nobackup
set hidden
set noswapfile
set backspace=2
set visualbell
set number
set wildmode=list:longest,full
set listchars=tab:\|\ 
set list
set scrolloff=0
set laststatus=2
set cmdheight=1
set showcmd
"set linespace=0
set report=0
let &statusline = "%m%r%y%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%< %=%F"

" http://vim-users.jp/2010/07/hack162/
if has('persistent_undo')
  set undodir=$VIM_CONFIG_DIR/vimundo
  set undofile
endif

" }}}

" ### key mapping ### {{{
let mapleader = ","
map <Space> [Space]
noremap [Space] <Nop>
nnoremap j gj
nnoremap k gk
inoremap <S-Insert> <C-r><C-o>+<C-[>
nnoremap <silent> <C-Up> :<C-u>resize +1<CR>
nnoremap <silent> <C-Down> :<C-u>resize -1<CR>
nnoremap <silent> <C-Right> :<C-u>vertical resize +1<CR>
nnoremap <silent> <C-Left> :<C-u>vertical resize -1<CR>
nnoremap <silent> gf <C-w>f
nnoremap <silent> gF <C-w>F
cnoremap <C-g> <C-r>=expand('%:p:h')<CR>/

" like Emacs
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
" http://vim.g.hatena.ne.jp/tyru/20100116
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
inoremap <expr> <C-k> "\<C-g>u".(col('.') == col('$') ? '<C-o>gJ' : '<C-o>D')
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0

" Undoable <C-w> and <C-u>.
" http://whileimautomaton.net/2007/10/21095500
inoremap <C-w>  <C-g>u<C-w>
inoremap <C-u>  <C-g>u<C-u>

" http://vim-jp.org/blog/2015/06/30/visual-ctrl-a-ctrl-x.html
vnoremap <c-a> <c-a>gv
vnoremap <c-x> <c-x>gv
" }}}

" ### misc ### {{{

set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,iso-2022-jp,euc-jisx0213,euc-jp,sjis,cp932,utf-8

" http://blog.blueblack.net/item_393
augroup InsModeAu
  autocmd!
  autocmd InsertEnter,CmdwinEnter * set noimdisable
  autocmd InsertLeave,CmdwinLeave * set imdisable
augroup END

" http://d.hatena.ne.jp/spiritloose/20060519/1147970872
function! s:AddExecmod()
  let line = getline(1)
  if strpart(line, 0, 2) == "#!"
    call system("chmod +x ". expand("%"))
  endif
endfunction
augroup executable
  autocmd BufWritePost * :call s:AddExecmod()
augroup END

" }}}

" ### color setting ### {{{
if has('gui_running')
  colo dracula
else
  "set t_Co=256
  if g:tinyvim == 0
    "colo Tomorrow-Night-Bright
    colo dracula
  else
    colo dracula
  endif
endif
" }}}
