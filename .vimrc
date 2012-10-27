" /* vim: set fdm=marker: */
" map z[ocRM]

set nocompatible

" ### vundle start ### {{{
filetype off " required!
set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.vim/vundle/
call vundle#rc()
Bundle 'https://github.com/gmarik/vundle'
Bundle 'https://github.com/Shougo/vimproc'
Bundle 'https://github.com/Shougo/unite.vim'
Bundle 'https://github.com/hakobe/unite-script'
Bundle 'https://github.com/ujihisa/unite-colorscheme'
Bundle 'https://github.com/h1mesuke/unite-outline'
Bundle 'https://github.com/ujihisa/unite-font'
Bundle 'https://github.com/sjl/gundo.vim'
Bundle 'https://github.com/tpope/vim-surround'
Bundle 'https://github.com/thinca/vim-quickrun'
Bundle 'https://github.com/vim-scripts/YankRing.vim'
Bundle 'https://github.com/vim-scripts/yanktmp.vim'
Bundle 'https://github.com/othree/eregex.vim'
Bundle 'https://github.com/tsaleh/vim-align'
Bundle 'https://github.com/vim-scripts/Rename'
Bundle 'https://github.com/t9md/vim-surround_custom_mapping'
Bundle 'https://github.com/kana/vim-textobj-user'
Bundle 'https://github.com/kana/vim-textobj-indent'
Bundle 'https://github.com/kien/ctrlp.vim'
Bundle 'https://github.com/vim-scripts/sudo.vim'
Bundle 'https://github.com/scrooloose/syntastic'
Bundle 'https://github.com/nathanaelkane/vim-indent-guides'
Bundle 'https://github.com/thinca/vim-ref'
" syntax
Bundle 'https://github.com/kchmck/vim-coffee-script'
Bundle 'https://github.com/briancollins/vim-jst'
Bundle 'https://github.com/othree/html5.vim'
Bundle 'https://github.com/hail2u/vim-css-syntax'
Bundle 'https://github.com/hail2u/vim-css3-syntax'
Bundle 'https://github.com/jelera/vim-javascript-syntax'
" testing
Bundle 'https://github.com/Shougo/vimshell'
Bundle 'https://github.com/airblade/vim-rooter'
" colorschemes
Bundle 'git://gist.github.com/187578.git'
Bundle 'https://github.com/vim-scripts/Zenburn'
Bundle 'https://github.com/vim-scripts/darkburn'
Bundle "https://github.com/nanotech/jellybeans.vim"
Bundle 'https://github.com/vim-scripts/Lucius'
Bundle "https://github.com/chriskempson/vim-tomorrow-theme"
Bundle 'https://github.com/vim-scripts/mrkn256.vim'
Bundle 'https://github.com/trapd00r/neverland-vim-theme'
Bundle 'https://github.com/altercation/solarized'
Bundle 'https://github.com/tomasr/molokai'
Bundle 'https://github.com/aereal/vim-magica-colors'
Bundle 'https://github.com/bluntpeak/bluntpeak-vim-colors'
Bundle 'https://github.com/liquidz/vim-colors-uochan'
Bundle 'https://github.com/ricardovaleriano/vim-github-theme'
Bundle 'https://github.com/uu59/vim-herokudoc-theme'
" pending
"Bundle 'https://github.com/thinca/vim-fontzoom'
"Bundle 'https://github.com/flazz/vim-colorschemes'
"Bundle 'https://github.com/Shougo/neocomplcache'
"Bundle 'https://github.com/vim-scripts/textobj-rubyblock'
"Bundle 'https://github.com/tpope/vim-pathogen'
filetype plugin indent on " required!
" ### vundle end ###
" }}}

" ### set variables ### {{{
syntax enable
set showmatch
set matchtime=0
set ambiwidth=double
set mouse=
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
set statusline=%m%r%y%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%<\ %=%F

" http://vim-users.jp/2010/07/hack162/
if has('persistent_undo')
    set undodir=~/.vimundo
    set undofile
endif

" }}}

" ### filetype setting ### {{{
augroup FileTypes
  autocmd!
  au BufEnter *   execute ":lcd " . expand("%:p:h")
  au BufEnter *.erubis execute "setlocal ft=eruby"
  au BufEnter Gemfile execute "setlocal ft=ruby"
  au BufEnter Rakefile execute "setlocal ft=ruby"
  au BufEnter config.ru execute "setlocal ft=ruby"

  au BufNewFile *.sh,*.bash execute "0r ~/.vim/template/bash.txt"
  \ | execute "17"

  au BufNewFile *.rb execute "0r ~/.vim/template/ruby.txt"
  \ | execute "10"
  \ | " move to last line

  au BufNewFile *.html 0r ~/.vim/template/html.txt
  \ | execute "10d"
  \ | execute "8"

  au BufNewFile *.user.js 0r ~/.vim/template/user.js.txt
  \ | execute "11d"
  \ | execute "9"

  au BufEnter *.mkd,*.markdown setlocal wrap

  au BufEnter *.php setlocal noexpandtab
augroup END
" }}}

" ### key mapping ### {{{
let mapleader = " "
nnoremap j gj
nnoremap k gk
inoremap <S-Insert> <C-r><C-o>+<C-[>
nnoremap <silent> <C-Up> :<C-u>resize +1<CR>
nnoremap <silent> <C-Down> :<C-u>resize -1<CR>
nnoremap <silent> <C-Right> :<C-u>vertical resize +1<CR>
nnoremap <silent> <C-Left> :<C-u>vertical resize -1<CR>
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

" yanktmp.vim {{{
"map <silent> Sy :call YanktmpYank()<CR>
"map <silent> Sp :call YanktmpPaste_p()<CR>
"map <silent> SP :call YanktmpPaste_P()<CR>
" }}}

" quickrun.vim {{{
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
      \ 'outputter': 'browser',
      \ 'type': 'markdown/redcarpet'
      \ }
" }}}

" unite.vim {{{
let g:unite_enable_start_insert=1
noremap <Leader>u :Unite 
noremap <Leader>b :Unite buffer<CR>
noremap <Leader>o :Unite outline<CR>
"noremap <Leader>f :Unite file buffer<CR>
" }}}

" gundo.vim {{{
nnoremap U :<C-u>GundoToggle<CR>
" }}}

" -- ctrlp.vim {{{
let g:ctrlp_map = '<Leader>f'
let g:ctrlp_arg_map = 1
" }}}

" -- yankring.vim {{{
let g:yankring_manual_clipboard_check = 0
" }}}

" -- indent-guides.vim {{{
nnoremap <C-j> :<C-u>IndentGuidesToggle<CR>
" }}}

" -- ref.vim {{{
let g:ref_source_webdict_sites = {
\   'je': {
\     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
\     'line': 21,
\   },
\   'ej': {
\     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
\     'line': 21,
\   },
\   'naver': {
\     'url': 'http://endic.naver.jp/srch/all/N/%s?sm=etp_enh',
\     'line': 40,
\   },
\   'weblio': {
\     'url': 'http://www.weblio.jp/content/%s',
\     'line': 14,
\   },
\   'thesaurus': {
\     'url': 'http://thesaurus.weblio.jp/content/%s',
\     'line': 27,
\   },
\   'thesaurus-en': {
\     'url': 'http://thesaurus.com/browse/%s?s=t',
\     'line': 76,
\   },
\   'urban': {
\     'url': 'http://www.urbandictionary.com/define.php?term=%s',
\     'line': 13,
\   },
\   'ruby-class': {
\     'url': 'http://doc.ruby-lang.org/ja/1.9.3/class/%s.html',
\   },
\   'twitter': {
\     'url': 'https://mobile.twitter.com/search?q=%s',
\     'line': 8,
\     'cache': 0,
\   },
\ }
nnoremap <Leader>d :<C-u>Ref webdict 
let g:ref_source_webdict_use_cache = 1
" }}}

" -- syntastic.vim {{{
let g:syntastic_error_symbol='⚔' " ☠ ✗ ☣ ☢
let g:syntastic_warning_symbol='⚐' " ☹  ⚠
" }}}

" -- VimShell {{{
" cecutils.vim uses <Leader>sqp mapping
" http://www.jukie.net/~bart/conf/vim/plugin/cecutil.vim
" so <Leader>s will wait for `timeoutlen` msec for more input
" note: You can unmap by after/* or remove cecutil.vim
set timeoutlen=150
nnoremap <silent> <Leader>s :<C-u>VimShell -popup<CR>
function! s:vimshell_keymap()
  imap <buffer><silent> <C-d> exit<CR>
endfunction

augroup VimShell
  autocmd!
  au FileType vimshell call s:vimshell_keymap()
augroup END
" }}}

" vim-rooter.vim {{{
let g:rooter_patterns = ['.git/', "spec/", "Gemfile", 'Rakefile', "manifest.json", "package.json"]
let g:rooter_use_lcd = 1
augroup rooter
  autocmd!
  autocmd BufEnter * :Rooter
augroup END
" }}}

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

