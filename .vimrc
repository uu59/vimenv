" /* vim: set fdm=marker: */

set nocompatible

" ### neobundle start ### {{{
filetype off " required!
if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/neobundle/'))

" core/generic
NeoBundle 'https://github.com/Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
NeoBundle 'https://github.com/Shougo/unite.vim'
NeoBundle 'https://github.com/hakobe/unite-script'
NeoBundle 'https://github.com/ujihisa/unite-colorscheme'
NeoBundle 'https://github.com/Shougo/unite-outline'
NeoBundle 'https://github.com/thinca/vim-unite-history'
NeoBundle 'https://github.com/ujihisa/unite-font'
NeoBundle 'https://github.com/sjl/gundo.vim'
NeoBundle 'https://github.com/tpope/vim-surround'
NeoBundle 'https://github.com/thinca/vim-quickrun'
NeoBundle 'https://github.com/vim-scripts/YankRing.vim'
NeoBundle 'https://github.com/othree/eregex.vim'
NeoBundle 'https://github.com/tsaleh/vim-align'
NeoBundle 'https://github.com/vim-scripts/Rename'
NeoBundle 'https://github.com/t9md/vim-surround_custom_mapping'
NeoBundle 'https://github.com/kana/vim-textobj-user'
NeoBundle 'https://github.com/kana/vim-textobj-indent'
NeoBundle 'https://github.com/kien/ctrlp.vim'
NeoBundle 'https://github.com/vim-scripts/sudo.vim'
NeoBundle 'https://github.com/scrooloose/syntastic'
NeoBundle 'https://github.com/nathanaelkane/vim-indent-guides'
NeoBundle 'https://github.com/thinca/vim-ref'
NeoBundle 'https://github.com/airblade/vim-rooter'
NeoBundle 'https://github.com/mattn/webapi-vim'

" conditional load
NeoBundleLazy 'https://github.com/godlygeek/csapprox'
NeoBundleLazy 'https://github.com/Shougo/vimshell'
NeoBundleLazy 'https://github.com/mattn/benchvimrc-vim'

" syntax / language specific
NeoBundle 'https://github.com/kchmck/vim-coffee-script'
NeoBundle 'https://github.com/briancollins/vim-jst'
NeoBundle 'https://github.com/othree/html5.vim'
NeoBundle 'https://github.com/hail2u/vim-css-syntax'
NeoBundle 'https://github.com/hail2u/vim-css3-syntax'
NeoBundle 'https://github.com/teramako/jscomplete-vim'
"NeoBundle 'https://github.com/jelera/vim-javascript-syntax'
NeoBundle 'https://github.com/zaiste/tmux.vim'

" testing
NeoBundle 'https://github.com/rhysd/vim-textobj-ruby'
NeoBundle 'https://github.com/kana/vim-operator-user'
NeoBundle 'https://github.com/basyura/TweetVim', {
      \ 'rev':'dev'
      \ }
NeoBundle 'https://github.com/mattn/favstar-vim'
NeoBundle 'https://github.com/tyru/open-browser.vim'
NeoBundle 'https://github.com/basyura/twibill.vim'
NeoBundle "https://github.com/sgur/unite-git_grep"
"NeoBundle 'https://github.com/airblade/vim-gitgutter'
"NeoBundle 'https://github.com/akiomik/git-gutter-vim'

" colorschemes
NeoBundle 'git://gist.github.com/187578.git'
NeoBundle 'https://github.com/vim-scripts/Zenburn'
NeoBundle 'https://github.com/vim-scripts/darkburn'
NeoBundle "https://github.com/nanotech/jellybeans.vim"
NeoBundle 'https://github.com/vim-scripts/Lucius'
NeoBundle "https://github.com/chriskempson/vim-tomorrow-theme"
NeoBundle 'https://github.com/vim-scripts/mrkn256.vim'
NeoBundle 'https://github.com/trapd00r/neverland-vim-theme'
NeoBundle 'https://github.com/altercation/solarized'
NeoBundle 'https://github.com/tomasr/molokai'
NeoBundle 'https://github.com/aereal/vim-magica-colors'
NeoBundle 'https://github.com/bluntpeak/bluntpeak-vim-colors'
NeoBundle 'https://github.com/liquidz/vim-colors-uochan'
NeoBundle 'https://github.com/ricardovaleriano/vim-github-theme'
NeoBundle 'https://github.com/vol2223/vim-colorblind-colorscheme'

if empty(finddir('vim-herokudoc-theme', $HOME.'/works'))
  NeoBundle 'https://github.com/uu59/vim-herokudoc-theme'
else
  " for my development
  NeoBundle 'https://github.com/uu59/vim-herokudoc-theme', {
        \ 'rtp': $HOME . '/works/vim-herokudoc-theme/'
        \ }
endif

" pending
"NeoBundle 'https://github.com/thinca/vim-fontzoom'
"NeoBundle 'https://github.com/flazz/vim-colorschemes'
"NeoBundle 'https://github.com/Shougo/neocomplcache'
"NeoBundle 'https://github.com/vim-scripts/textobj-rubyblock'
"NeoBundle 'https://github.com/tpope/vim-pathogen'

" gui or not
if has('gui_running')
  NeoBundleSource vimshell
else
  NeoBundleSource benchvimrc-vim
  " csapprox takes 63 msec(25% of all) for startup vim on my machine.
  " if you need csapprox power, comment in below line
  "NeoBundleSource csapprox
end

filetype plugin indent on " required!

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoNeoBundleInstall" command.'
endif
" }}}

" ### set variables ### {{{
syntax enable
set showmatch
set matchtime=0
set ambiwidth=double
set mouse=
set history=1000
set title
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
  set undodir=~/.vimundo
  set undofile
endif

" }}}

" ### filetype setting ### {{{
augroup FileTypes
  autocmd!

  au BufEnter * execute ":lcd" . expand("%:p:h")

  au BufEnter *.erubis   setlocal ft=eruby
  au BufEnter *.coffee   setlocal ft=coffee
  au BufEnter Gemfile    setlocal ft=ruby
  au BufEnter Rakefile   setlocal ft=ruby
  au BufEnter config.ru  setlocal ft=ruby
  au BufEnter *.md,*.mkd setlocal ft=markdown " .md is not modula2

  au BufNewFile *.sh,*.bash execute "0r ~/.vim/template/bash.txt"
  \ | execute "17"

  au BufNewFile *.rb execute "0r ~/.vim/template/ruby.txt"
  \ | execute "10"

  au BufNewFile *.html 0r ~/.vim/template/html.txt
  \ | execute "silent 11d"
  \ | execute "9"

  au BufNewFile *.user.js 0r ~/.vim/template/user.js.txt
  \ | execute "silent 11d"
  \ | execute "9"

  au BufNewFile manifest.json 0r ~/.vim/template/manifest.json
  au BufNewFile Gemfile 0r ~/.vim/template/Gemfile
  au BufNewFile spec_helper.rb 0r ~/.vim/template/spec_helper.rb

  au FileType markdown setlocal wrap
  au FileType php setlocal noexpandtab
  au FileType javascript setlocal omnifunc=jscomplete#CompleteJS
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
nnoremap <silent> gf <C-w>f
nnoremap <silent> gF <C-w>F

" operator-user.vimに登録
call operator#user#define('datauri', 'g:datauri')
call operator#user#define('markdownlink', 'g:markdownlink')
vmap B <Plug>(operator-datauri)
vmap T <Plug>(operator-markdownlink)

"noremap <C-f> :<C-u>echo expand('%:p')<CR>
"inoremap <C-f> <C-r>=expand('%:p')<CR>
" }}}

" ### color setting ### {{{
"colo twilight
"colo zmrok
if has('gui_running')
  colo herokudoc " MacVim doesn't reach here
else
  "let g:zenburn_high_Contrast = 1
  "NeoBundleSource csapprox
  "set t_Co=256
  colo Tomorrow-Night
endif
" }}}

" ### plugin setting ### {{{

" -- TweetVim{{{
let g:tweetvim_tweet_per_page = 200
let g:tweetvim_include_rts    = 1
let g:tweetvim_display_source = 1
let g:tweetvim_display_time   = 1
let g:tweetvim_display_icon = 1
let g:tweetvim_expand_t_co = 1

function! s:tweetvim_keymap()
  nnoremap <buffer><silent> t :Unite tweetvim<CR>
  nnoremap <buffer><silent> I :<C-u>TweetVimSay<CR>
  nmap <silent><buffer> <leader>f  <NOP>
  nmap <silent><buffer> <leader>uf <NOP>
  nmap <silent><buffer> F <Plug>(tweetvim_action_favstar)
  nmap <buffer><silent> <C-m> :<C-u>source ~/.vimrc.tweetvim<CR>
  nmap <silent><buffer> <C-r> <Plug>(tweetvim_action_reload)
endfunction

augroup TweetVim
  autocmd!
  au FileType tweetvim call s:tweetvim_keymap()
  au FileType tweetvim setlocal wrap
augroup END

nmap <Space>tw :<C-u>TweetVimHomeTimeline<CR><C-m>

" }}}

" -- quickrun.vim {{{
let g:quickrun_config = {}
let g:quickrun_config = {
      \   "_" : {
      \       "runner" : "vimproc",
      \       "runner/vimproc/updatetime" : 60
      \   },
      \ }
let g:quickrun_config['markdown'] = {
      \ 'outputter': 'browser',
      \ 'type': 'markdown/redcarpet'
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
" }}}

" -- unite.vim {{{
let g:unite_enable_start_insert=1
noremap <Leader>u :Unite 
noremap <Leader>b :Unite buffer<CR>
noremap <Leader>o :Unite outline<CR>
"noremap <Leader>f :Unite file buffer<CR>
noremap <Leader>h :Unite history/command<CR>
noremap <Leader>g :Unite vcs_grep<CR>
" }}}

" -- gundo.vim {{{
nnoremap U :<C-u>GundoToggle<CR>
" }}}

" -- ctrlp.vim {{{
let g:ctrlp_map = '<Leader>f'
let g:ctrlp_arg_map = 1
let g:ctrlp_max_height = 8
let g:ctrlp_cache_dir = '/tmp/ctrlp'
if executable('find') == 1 && executable('grep') == 1 && executable('head') == 1
  let g:ctrlp_user_command =
    \ 'find %s -type f -o \( -name .git -o -name tmp -o -name .hg -name .svn \) -prune -type f | head -10000 | grep -v -E "\.(jpe?g|png|gif|[ot]tf|ico)$"'
endif

let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")': ['<C-n>'],
  \ 'PrtSelectMove("k")': ['<C-p>'],
  \ 'PrtHistory(-1)': [],
  \ 'PrtHistory(1)':  [],
  \ 'PrtClearCache()':      ['<F5>', '<S-space>'],
  \ 'PrtBS()':              ['<bs>', '<c-]>', '<C-h>'],
  \ 'PrtCurLeft()':         ['<C-b>', '<left>', '<c-^>'],
  \ 'PrtCurRight()':        ['<C-f>', '<right>'],
  \ 'ToggleType(1)':        ['<C-Tab>', '<c-up>'],
  \ 'MarkToOpen()':         ['<C-v>', '<c-z>'],
  \ 'AcceptSelection("v")': [],
  \ }
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
\   'caniuse': {
\     'url': 'http://caniuse.com/%s/embed/agents=desktop',
\     'line': 20,
\   },
\ }
nnoremap <Leader>d :<C-u>Ref webdict 
let g:ref_source_webdict_use_cache = 1
" }}}

" -- syntastic.vim {{{
let g:syntastic_javascript_jshint_conf = "~/.vim/jshintrc"
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

" -- vim-rooter.vim {{{
let g:rooter_patterns = ['.git/', "spec/", "Gemfile", 'Rakefile', "manifest.json", "package.json"]
let g:rooter_use_lcd = 1
augroup rooter
  autocmd!
  autocmd BufEnter * :Rooter
  autocmd FileType html,ruby,scss,css,javascript execute ':setlocal path+=' .expand('%:p:h')
  autocmd FileType html,ruby,scss,css,javascript setlocal includeexpr=substitute(v:fname,'^\\/','','')
augroup END
" }}}

" -- jscomplete-vim {{{
let g:jscomplete_use = ["dom", "es6th"]
" }}}

" }}}

" ### functions ### {{{

" -- g:markdownlink() {{{
function! g:markdownlink(motion_wise)
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
" }}}

" -- g:datauri() {{{
function! g:datauri(motion_wise)
  " v, V, <C-v>のどれで選択したのかで変わる
  " ここではvで選択したときだけ実行する
  if a:motion_wise !=# 'char'
    return
  endif

  " base64コマンドがなければどうしようもないので何もしない
  if executable('base64') == 0
    return
  endif

  " zレジスタを後で元に戻す用
  let backup_z = getreg('z', 1)
  let backup_ztype = getregtype('z')

  " zレジスタに選択範囲を入れる
  execute 'silent normal! `[v`]"zy'

  " `set path?`の中身を考慮しつつフルパスを探る
  " setlocal path=/project/public,. なとき、"/icons/foo.png"を選択して実行されると
  " /project/public/foo.png と ./icons/foo.png をチェックする
  let filename = getreg('z', 1)
  let filepath = ""
  for dir in split(&path, ',')
    let tmp = substitute(dir . "/" . filename, "//", "/", "g")
    if filereadable(tmp) == 1
      let filepath = tmp
    endif
  endfor

  " 見つからなかったので何もせずに終わり
  if empty(filepath)
    call setreg('z', backup_z, backup_ztype)
    return
  end

  " 場合によっては数秒かかるのでメッセージを出しておく
  echo "Encoding " . filepath . " .."

  " mimetypeコマンドがない場合のデフォルト
  let mime = ""
  " あればvimprocを使う
  if exists('*vimproc#system()') == 1
    if executable('mimetype') == 1
      let mime = vimproc#system('mimetype -b '. filepath) . ";"
    endif
    let body = vimproc#system('base64 -w 0 ' . filepath)
  else
    if executable('mimetype') == 1
      let mime = vimproc#system('mimetype -b '. filepath) . ";"
    endif
    let body = system('base64 -w 0 ' . filepath)
  endif
  let uri = "data:" . mime . "base64," . body

  " いったんzレジスタに突っ込んで選択範囲をそれで置き換える
  exec setreg('z', substitute(uri, "\n", "", "g"))
  silent normal! gv"zp

  " zレジスタの中身を実行前のものに差し戻して終わり
  call setreg('z', backup_z, backup_ztype)
endfunction
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

" }}}

