" /* vim: set fdm=marker: */

set nocompatible

"### initialize ### {{{
if has('nvim') && !exists('g:nyaovim_version')
  let g:nyaovim_version = '1' " adhoc workaround
endif

if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = $HOME . '/.config'
endif
let $VIM_CONFIG_DIR=$XDG_CONFIG_HOME . '/vim'
set runtimepath=$VIM_CONFIG_DIR,$VIM,$VIMRUNTIME

source $VIM_CONFIG_DIR/plug.vim

"}}}

" ### set variables ### {{{
colo dracula

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

" utility
vnoremap <silent> tb :!ruby $VIM_CONFIG_DIR/csv-md-table.rb<CR>

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

if exists(':tnoremap')
  tnoremap <silent> <ESC><ESC> <C-\><C-n>
endif
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

" for tmux: http://stackoverflow.com/a/15095377
set t_ut=

" -- Markdownlink() {{{
function! Markdownlink(motion_wise)
  if a:motion_wise !=# 'char'
    return
  endif
  let backup_z = getreg('z', 1)
  let backup_ztype = getregtype('z')
  execute 'silent normal! `[v`]"zy'
  let url = getreg('z', 1)
  echo "Fetching ".url." ..."
  let html = webapi#http#get(url)
  let title = webapi#html#parse(html.content).find('title').value()
  exec setreg('z', substitute("[".title."](".url.")", "\n", "", "g"))
  silent normal! gv"zp
  call setreg('z', backup_z, backup_ztype)
endfunction

call operator#user#define('markdownlink', 'Markdownlink')
vmap tt <Plug>(operator-markdownlink)
" }}}

" }}}

" ### filetype setting ### {{{
augroup FileTypes
  autocmd!

  "au BufEnter * execute ":lcd" . expand("%:p:h")

  au BufEnter *.erubis   setlocal ft=eruby
  au BufEnter *.bats     setlocal ft=sh
  au BufEnter *.jbuilder setlocal ft=ruby

  au BufEnter Gemfile    setlocal ft=ruby
  au BufEnter Rakefile   setlocal ft=ruby
  au BufEnter config.ru  setlocal ft=ruby
  au BufEnter *.md,*.mkd setlocal ft=markdown " .md is not modula2

  au BufNewFile *.sh,*.bash execute "0r $XDG_CONFIG_HOME/vim/template/bash.txt"
  \ | execute ":normal GV{{"

  au BufNewFile PKGBUILD execute "0r  $XDG_CONFIG_HOME/vim/template/PKGBUILD"

  au BufNewFile *.html 0r  $XDG_CONFIG_HOME/vim/template/html.txt
  \ | execute "silent 11d"
  \ | execute "9"

  au BufNewFile *.user.js 0r $XDG_CONFIG_HOME/vim/template/user.js.txt
  \ | execute "silent 11d"
  \ | execute "9"

  au BufNewFile manifest.json 0r  $XDG_CONFIG_HOME/vim/template/manifest.json
  au BufNewFile Gemfile 0r  $XDG_CONFIG_HOME/vim/template/Gemfile
  au BufNewFile spec_helper.rb 0r  $XDG_CONFIG_HOME/vim/template/spec_helper.rb

  au FileType markdown setlocal wrap
  au FileType text setlocal textwidth=0
  au FileType yaml setlocal fdm=indent
augroup END
" }}}

" ### plugin setting ### {{{

" -- quickrun.vim {{{
map <Space>r <Plug>(quickrun)
let g:quickrun_config = {}
let g:quickrun_config = {
      \   "_" : {
      \       "runner" : "vimproc",
      \       "runner/vimproc/updatetime" : 60
      \   },
      \ }
let g:quickrun_config['markdown'] = {
      \ 'outputter': 'browser',
      \ 'command': 'kramdown',
      \ 'cmdopt': '-i GFM'
      \ }
let g:quickrun_config['sass'] = {
      \ 'cmdopt': '`compass imports`'
      \ }
let g:quickrun_config['scss'] = {
      \ 'cmdopt': '`compass imports`'
      \ }
let g:quickrun_config['coffee'] = {
      \ 'cmdopt': '-p'
      \ }
let g:quickrun_config['javascript'] = {
      \ 'command': 'babel'
      \ }
" }}}

" -- ale.vim {{{
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
" }}}

" -- undotree.vim {{{
let g:undotree_SetFocusWhenToggle = 1
nnoremap U :<C-u>UndotreeToggle<CR>
" }}}

" -- fzf.vim {{{
let g:fzf_layout = { 'down': '~60%' }

nnoremap <silent> [Space]fg :<C-u>call fzf#run(fzf#wrap({
      \ 'source': 'ghq list --full-path',
      \   'sink': 'lcd' }))<CR>

nnoremap <silent> [Space]ff :<C-u>call fzf#run(fzf#wrap({
      \ 'source': 'git ls-files',
      \   'sink': 'e' }))<CR>

" fzf-funky
nnoremap <silent> [Space]ft :<C-u>call ctrlp#funky#funky(&ft)<CR>

" }}}

" -- yankround.vim {{{
let g:yankround_max_history = 1000
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
" }}}

" -- indent-guides.vim {{{
"nnoremap <C-j> :<C-u>IndentGuidesToggle<CR>
" }}}

" -- indentLines {{{
nnoremap <C-j> :<C-u>IndentLinesToggle<CR>
" let g:indentLine_char = '│'
"let g:indentLine_concealcursor = 'inc'
"let g:indentLine_conceallevel = 2
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_enabled = 0
"  }}}

" -- ref.vim {{{
let g:ref_source_webdict_sites = {
\   'je': {
\     'url': 'http://dictionary.goo.ne.jp/srch/je/%s/m0u/',
\     'line': 36,
\   },
\   'ej': {
\     'url': 'http://dictionary.goo.ne.jp/srch/ej/%s/m0u/',
\     'line': 36,
\   },
\   'alc': {
\     'url': 'http://eow.alc.co.jp/search?q=%s',
\     'line': 31,
\   },
\   'weblio': {
\     'url': 'http://www.weblio.jp/content/%s',
\     'line': 30,
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
\     'url': 'http://doc.ruby-lang.org/ja/2.1.0/class/%s.html',
\   },
\   'twitter': {
\     'url': 'https://mobile.twitter.com/search?q=%s',
\     'line': 8,
\     'cache': 0,
\   },
\   'caniuse': {
\     'url': 'http://caniuse.com/%s/embed/agents=desktop',
\     'line': 20,
\   },
\   'codic': {
\     'url': 'http://codic.jp/search?q=%s',
\     'line': 17,
\   },
\ }
nnoremap [Space]d :<C-u>Ref webdict 
let g:ref_source_webdict_use_cache = 0
" }}}

" -- syntastic.vim {{{
let g:syntastic_javascript_jshint_arg = "~/.vim/jshintrc"
let g:syntastic_error_symbol='⚔' " ☠ ✗ ☣ ☢
let g:syntastic_warning_symbol='⚐' " ☹  ⚠
" }}}

" -- vim-rooter.vim {{{
let g:rooter_patterns = ['.git/', "spec/", "Gemfile", 'Rakefile', "manifest.json", "package.json"]
let g:rooter_use_lcd = 1
augroup rooter
  autocmd!
  autocmd BufEnter * :Rooter
  autocmd FileType html,ruby,scss,css,javascript,coffee execute ':setlocal path+=' .expand('%:p:h')
  autocmd FileType html,ruby,scss,css,javascript,coffee setlocal includeexpr=substitute(v:fname,'^\\/','','')
augroup END
" }}}

" -- anzu {{{
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" }}}

" -- lightline.vim {{{
let g:lightline = {
      \ 'colorscheme': has('gui_running') ? 'solarized_dark' : 'Tomorrow_Night',
      \ 'active': {
      \   'left': [ [ 'mode' ],
      \             [ 'readonly', 'repo', 'fugitive' ] ],
      \   'right': [ [ 'absolutepath', 'modified' ], [ 'filetype'], ['fileformat', 'fileencoding'] ],
      \ },
      \ 'inactive': {
      \   'left': [ ['mode'] ],
      \   'right': [ [ 'absolutepath', 'modified' ], [ 'filetype'], ['fileformat', 'fileencoding'] ],
      \ },
      \ 'component': {
      \   'fugitive': '%{LightlineSpecialBuffer() ? "" : fugitive#head()}',
      \   'repo': '%{LightlineSpecialBuffer() || !fugitive#is_git_dir(fugitive#extract_git_dir(".")) ? "" : fnamemodify(getcwd(), ":t")  }',
      \   'modified': '%{&modified? "➕" : ""}',
      \   'filetype': '%{LightlineSpecialBuffer() ? "" : &ft}',
      \   'fileformat': '%{LightlineSpecialBuffer() ? "" : &ff == "unix" ? "" : &ff}',
      \   'fileencoding': '%{LightlineSpecialBuffer() ? "" : &fenc == "utf-8" ? "" : &fenc}',
      \   'readonly': '%{&readonly ? "⛌" :""}',
      \   'absolutepath': '%{LightlineSpecialBuffer() ? "" : substitute(expand("%:p"), $HOME, "~", "")}',
      \ },
      \ 'component_function': {
      \   'mode': 'LightlineMode',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ }

function! LightlineModeString()
  let l:fname = expand('%:t')
  return  l:fname == '__Tagbar__' ? 'Tagbar' :
        \ l:fname == 'ControlP' ? 'CtrlP' :
        \ l:fname =~ 'undotree_' ? 'Undotree' :
        \ l:fname =~ 'diffpanel_' ? 'Undotree diff' :
        \ l:fname =~ 'ref-webdict' ? 'webdict' :
        \ l:fname =~ 'quickrun' ? 'quickrun' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' : lightline#mode()
endfunction

function! LightlineSpecialBuffer()
  return LightlineModeString() != lightline#mode()
endfunction

function! LightlineMode()
  return !LightlineSpecialBuffer() && winwidth('.') < 60 ? "" : LightlineModeString()
endfunction
" }}}

" -- signify {{{
let g:signify_disable_by_default = 1
let g:signify_diffoptions = { 'git': '-w' }
nnoremap <silent> [Signify]s :<C-u>call sy#toggle()<CR>
nnoremap <silent> [Signify]S :<C-u>call sy#highlight#line_toggle()<CR>
nmap [Signify]j <plug>(signify-next-hunk)
nmap [Signify]k <plug>(signify-prev-hunk)
" }}}

" -- submode {{{
" http://d.hatena.ne.jp/osyo-manga/20130324/1364128144
map [Space] \S
let g:submode_timeout = 0
call submode#enter_with('signify', 'n', 'r', '[Space]s', '[Signify]s')
call submode#map('signify', 'n', 'r', 's', '[Signify]s')
call submode#map('signify', 'n', 'r', 'S', '[Signify]S')
call submode#map('signify', 'n', 'r', 'j', '[Signify]j')
call submode#map('signify', 'n', 'r', 'k', '[Signify]k')
" }}}

" EasyMotion {{{
let g:EasyMotion_leader_key = ','
let g:EasyMotion_startofline = 0
let g:EasyMotion_keys='kotpasdwneifj' " 最後の数文字が2文字以上のHaHのprefixになる
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0

" C-f使わないのでEasyMotion用にあてがう
"map <C-f> <Plug>(easymotion-s)
map <C-f> <Plug>(easymotion-s2)
"map <Space>j <Plug>(easymotion-bd-jk)
"map <Space>k <Plug>(easymotion-bd-jk)
" }}}

" open-browser.vim {{{
if has("mac")
  let g:openbrowser_browser_commands = [
        \ {"name": "open", "args": ["{browser}", "{uri}"] }
        \ ]
else
  let g:openbrowser_browser_commands = [
        \ {"name": "firefox", "args": ["{browser}", "{uri}"] },
        \ {"name": "w3m", "args": ["{browser}", "{uri}"] }
        \ ]
endif
" }}}

" committia.vim {{{
"let g:committia_hooks = {}
"function! g:committia_hooks.edit_open(info)
"    " Additional settings
"    setlocal spell
"
"    " If no commit message, start with insert mode
"    if a:info.vcs ==# 'git' && getline(1) ==# ''
"        startinsert
"    end
"endfunction
" }}}

" vim-emoji {{{
set completefunc=emoji#complete
" }}}

" tabular {{{
vmap T :Tabular/
" }}}

" ** nyaovim ** {{{
if exists('g:nyaovim_version')
  " markdown {{{
  let g:markdown_preview_auto = 1
  let g:markdown_preview_eager = 1
  " }}}
endif
" }}}
" }}}

" ### GUI {{{
if has('gui_running')
  set guioptions=-rLbc
  set lines=40
  set columns=130
  set novb
  set noballooneval

  augroup GUIEvents
    autocmd!
    au BufEnter * setlocal noballooneval " ale.vim, or something others enable this.
  augroup END

  if has('unix') && !has('mac')
    set guifont=VLGothic\ 10
    set guifontwide=VLGothic\ 10
    set linespace=0
  endif

  if has('mac')
    set guifont=Osaka−等幅:h14
    set linespace=1
    colo dracula
    if has('gui_running')
      set transparency=10
      set lines=75
      set columns=240
    endif
  endif
endif
" }}}
