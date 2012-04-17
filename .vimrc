" /* vim: set fdm=marker: */
" map z[ocRM]

set nocompatible

" ### vundle start ### {{{
filetype off " required!
set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.vim/vundle/
call vundle#rc()
Bundle 'https://github.com/gmarik/vundle.git'
Bundle 'https://github.com/Shougo/unite.vim.git'
Bundle 'https://github.com/hakobe/unite-script'
Bundle 'https://github.com/trapd00r/neverland-vim-theme.git'
Bundle 'https://github.com/hail2u/vim-css3-syntax.git'
Bundle 'https://github.com/sjl/gundo.vim.git'
Bundle 'https://github.com/altercation/solarized'
Bundle 'https://github.com/ujihisa/unite-colorscheme.git'
Bundle 'git://gist.github.com/187578.git'
Bundle 'https://github.com/Shougo/vimproc'
"Bundle 'https://github.com/Shougo/vimshell'
Bundle 'https://github.com/othree/html5.vim'
Bundle 'https://github.com/h1mesuke/unite-outline'
Bundle 'https://github.com/mattn/webapi-vim'
Bundle 'https://github.com/mattn/gist-vim'
Bundle 'https://github.com/tpope/vim-surround'
Bundle 'https://github.com/thinca/vim-quickrun'
Bundle 'https://github.com/vim-scripts/YankRing.vim'
Bundle 'https://github.com/othree/eregex.vim'
Bundle 'https://github.com/vim-scripts/Zenburn'
Bundle 'https://github.com/vim-scripts/darkburn'
Bundle 'https://github.com/tsaleh/vim-align'
Bundle 'https://github.com/tpope/vim-pathogen'
Bundle 'https://github.com/vim-scripts/Rename'
Bundle 'https://github.com/tomasr/molokai'
Bundle 'https://github.com/sjl/gundo.vim.git'
Bundle 'https://github.com/t9md/vim-surround_custom_mapping'
Bundle 'https://github.com/vim-scripts/Lucius'
Bundle 'https://github.com/ChrisKempson/Vim-Tomorrow-Theme'
Bundle 'https://github.com/vim-scripts/mrkn256.vim'
Bundle 'https://github.com/ujihisa/unite-font'
Bundle 'https://github.com/flazz/vim-colorschemes'
Bundle 'https://github.com/thinca/vim-fontzoom'
Bundle 'https://github.com/tyru/open-browser.vim'
Bundle 'https://github.com/vim-scripts/yanktmp.vim'
"Bundle 'https://github.com/Shougo/neocomplcache'
Bundle 'https://github.com/kana/vim-textobj-user'
Bundle 'https://github.com/vim-scripts/textobj-rubyblock'
Bundle 'https://github.com/kchmck/vim-coffee-script'
Bundle 'https://github.com/briancollins/vim-jst'
Bundle 'https://github.com/kien/ctrlp.vim'
Bundle 'https://github.com/vim-scripts/sudo.vim'
Bundle 'https://github.com/scrooloose/syntastic'
Bundle 'https://github.com/nathanaelkane/vim-indent-guides'
Bundle 'https://github.com/aereal/vim-magica-colors'
Bundle 'https://github.com/bluntpeak/bluntpeak-vim-colors'
Bundle 'https://github.com/liquidz/vim-colors-uochan'
filetype plugin indent on " required!
" ### vundle end ###
" }}}

" ### set variables ### {{{
syntax enable
set showmatch
set matchtime=0
set ambiwidth=double
set mouse=a
set history=100000
set title
set titlestring=%F%(\ %M%)%(\ (%{getcwd()})%)%(\ %a%)
set completeopt=menuone,preview
set lazyredraw
set nu
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
set statusline=%r%y%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%<\ %=%m%F

" http://vim-users.jp/2010/07/hack162/
if has('persistent_undo')
    set undodir=~/.vimundo
    set undofile
endif
" }}}

" ### filetype setting ### {{{
au BufEnter *   execute ":lcd " . expand("%:p:h")
au BufEnter *.erubis execute "setlocal ft=eruby"

au BufNewFile *.rb execute "0r ~/.vim/template/ruby.txt"
\ | execute "10"
\ | " move to last line

au BufNewFile *.html 0r ~/.vim/template/html.txt
\ | execute "9d"
\ | execute "7"

au BufNewFile *.user.js 0r ~/.vim/template/user.js.txt
\ | execute "11d"
\ | execute "9"

au BufEnter *.mkd,*.markdown setlocal wrap

au BufEnter *.php setlocal noexpandtab
" }}}

" ### key mapping ### {{{
let mapleader = " "
nnoremap j gj
nnoremap k gk
inoremap <S-Insert> <C-r><C-o>+<C-[>
"noremap <C-f> :<C-u>echo expand('%:p')<CR>
"inoremap <C-f> <C-r>=expand('%:p')<CR>
" }}}

" ### color setting ### {{{
"set bg=dark
"set t_Co=256
"colo jellybeans
"colo twilight
"let g:zenburn_high_Contrast = 1
colo zenburn
"colo zmrok
" }}}

" ### plugin setting ### {{{
" gist.vim
let g:gist_open_browser_after_post = 1
"let g:gist_browser_command = 'chromium-browser %URL%'
let g:gist_detect_filetype = 1

" neocomplcache
"let g:acp_enableAtStartup = 0
"let g:neocomplcache_enable_at_startup = 1

" yanktmp.vim
"map <silent> Sy :call YanktmpYank()<CR>
"map <silent> Sp :call YanktmpPaste_p()<CR>
"map <silent> SP :call YanktmpPaste_P()<CR>

" quickrun
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
      \ 'outputter': 'browser',
      \ 'type': 'markdown/redcarpet'
      \ }

" unite.vim
let g:unite_enable_start_insert=1
noremap <Leader>u :Unite 
noremap <Leader>b :Unite buffer<CR>
noremap <Leader>o :Unite outline<CR>
noremap <Leader>f :Unite file buffer<CR>

" gundo
nnoremap U :<C-u>GundoToggle<CR>

" -- VimShell
"noremap ,sh :<C-u>VimShell<CR>
"noremap ,irb :<C-u>VimShellInteractive irb<CR>
"vnoremap ss :<C-u>VimShellSendString<CR>

" -- ctrlp.vim
let g:ctrlp_map = '<Leader><C-f>'
let g:ctrlp_arg_map = 1

" -- yankring.vim
let g:yankring_manual_clipboard_check = 0

" }}}

" ### misc ### {{{

set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,iso-2022-jp,euc-jisx0213,euc-jp,sjis,cp932,utf-8

" http://blog.blueblack.net/item_393
augroup InsModeAu
    autocmd!
    autocmd InsertEnter,CmdwinEnter * set noimdisable
    autocmd InsertLeave,CmdwinLeave * set imdisable
augroup END

if has("gui_running")
  source ~/.gvimrc
endif

" }}}

