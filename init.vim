" /* vim: set fdm=marker: */

let g:tinyvim = 0
if has('nvim') && !exists('g:nyaovim_version')
  let g:nyaovim_version = '1' " adhoc workaround
endif

if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = $HOME . '/.config'
endif

set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME

source $XDG_CONFIG_HOME/vim/basic-init.vim

" ### filetype setting ### {{{
augroup FileTypes
  autocmd!

  "au BufEnter * execute ":lcd" . expand("%:p:h")

  au BufEnter *.erubis   setlocal ft=eruby
  au BufEnter *.bats     setlocal ft=sh

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

" -- watchdogs (after quickrun config) {{{
let g:quickrun_config["watchdogs_checker/_"] = {
      \   'outputter/quickfix/open_cmd' : '',
      \ }
" errorformat for jruby and cruby
let g:quickrun_config["watchdogs_checker/ruby"] = {
      \   "command" : "ruby",
      \   "exec"    : "%c %o -W2 -c %s:p",
      \   "errorformat" : '%ESyntaxError in %f:%l: %m,'.
      \                   '%W%f:%l: warning: %m,'.
      \                   '%f:%l: %m',
      \ }
let g:quickrun_config["watchdogs_checker/eslint"] = {
      \   "command" :  $XDG_CONFIG_HOME."/vim/eslint_wrapper",
      \ }
let g:quickrun_config["javascript/watchdogs_checker"] = {
        \   "type" : "watchdogs_checker/eslint"
        \ }

"set errorformat+=%ESyntaxError\ in\ %f:%l:\ %m
call watchdogs#setup(g:quickrun_config)
let g:watchdogs_check_BufWritePost_enable = 1
let g:watchdogs_check_BufWritePost_enable_on_wq = 0
hi SpellBad ctermbg=1 ctermfg=0 guifg=#333333 guibg=#ff5555 gui=NONE
hi SpellLocal ctermbg=11 ctermfg=0 guifg=#333333 guibg=#cccc77 gui=NONE
hi SpellRare ctermfg=11 ctermfg=0 guifg=#333333 guibg=#aaaaaa gui=NONE
" }}}

" -- unite.vim {{{
let g:unite_enable_start_insert=1
noremap [Space]u :<C-u>Unite 
"noremap [Space]b :<C-u>Unite buffer<CR>
noremap [Space]o :<C-u>Unite outline<CR>
"noremap [Space]f :<C-u>Unite file_rec/async<CR>
noremap [Space]h :<C-u>Unite history/command<CR>
noremap [Space]g :<C-u>Unite vcs_grep/git<CR>

let g:unite_source_find_command =
    \ 'find %s -type f -o \( -name .git -o -name tmp -o -name .hg -name .svn \) -prune -type f | head -100 | grep -v -E "\.(jpe?g|png|gif|[ot]tf|ico)$"'
let g:unite_source_rec_async_command =
    \ 'find %s -type f -o \( -name .git -o -name tmp -o -name .hg -name .svn \) -prune -type f | head -100 | grep -v -E "\.(jpe?g|png|gif|[ot]tf|ico)$"'

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  imap <silent><buffer><expr> <C-o>s     unite#do_action('split')
  imap <silent><buffer><expr> <C-o>v     unite#do_action('vsplit')
endfunction
" }}}

" -- unite-git_grep.vim {{{
let g:unite_source_git_grep_required_pattern_length = 2
let g:unite_source_hg_grep_required_pattern_length = 2
" }}}

" -- gundo.vim {{{
nnoremap U :<C-u>GundoToggle<CR>
" }}}

" -- ctrlp.vim {{{
let g:ctrlp_map = '[Space]ff'
let g:ctrlp_arg_map = 1
let g:ctrlp_max_height = 12
let g:ctrlp_by_filename = 1 " <C-d> by default
let g:ctrlp_cache_dir = '/tmp/ctrlp'
if executable('find') == 1 && executable('grep') == 1 && executable('head') == 1
  let g:ctrlp_user_command =
    \ 'find %s -type f -o \( -name .cache -o -name .git -o -name tmp -o -name .hg -name .svn \) -prune -type f' .
    \ '| head -1000' .
    \ '| grep -v -i -E "\.(jpe?g|png|gif|[ot]tf|ico)$"'
endif
let g:ctrlp_yankring_disable = 1

noremap [Space]b :<c-u>CtrlPBuffer<cr>

" ctrl-funky
noremap [Space]fo :<c-u>CtrlPFunky<cr>
" ctrlp-ghq.vim
noremap [Space]fg :<c-u>CtrlPGhq<cr>
" ctrl-extensions
noremap [Space]f: :<c-u>CtrlPCmdline<cr>
noremap [Space]fy :<c-u>CtrlPYankring<cr>

let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")': ['<C-n>'],
  \ 'PrtSelectMove("k")': ['<C-p>'],
  \ 'PrtHistory(-1)': [],
  \ 'PrtHistory(1)':  [],
  \ 'PrtClearCache()':      ['<F5>', '<S-space>'],
  \ 'PrtBS()':              ['<bs>', '<c-]>', '<C-h>'],
  \ 'PrtCurLeft()':         ['<C-b>', '<left>', '<c-^>'],
  \ 'PrtCurRight()':        ['<C-f>', '<right>'],
  \ 'ToggleType(1)':        ['<Tab>'],
  \ 'MarkToOpen()':         ['<C-v>', '<c-z>'],
  \ 'AcceptSelection("v")': [],
  \ }
" }}}

" -- yankround.vim {{{
let g:yankround_max_history = 1000
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
" }}}

" -- indent-guides.vim {{{
nnoremap <C-j> :<C-u>IndentGuidesToggle<CR>
" }}}

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
      \   'left': [ [ 'mode', 'paste'],
      \             [ 'readonly', 'fugitive' ] ],
      \   'right': [ [ 'absolutepath', 'modified' ], [ 'filetype'], ['fileformat', 'fileencoding'] ],
      \ },
      \ 'inactive': {
      \   'left': [ ['mode'] ],
      \   'right': [ [ 'absolutepath', 'modified' ], [ 'filetype'], ['fileformat', 'fileencoding'] ],
      \ },
      \ 'component': {
      \   'fugitive': '%{LightlineSpecialBuffer() ? "" : fugitive#head()}',
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
        \ l:fname == '__Gundo__' ? 'Gundo' :
        \ l:fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ l:fname =~ 'ref-webdict' ? 'webdict' :
        \ l:fname =~ 'quickrun' ? 'quickrun' :
        \ &ft == 'unite' ? 'Unite' :
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
        \ {"name": "w3m", "args": ["{browser}", "{uri}"] },
        \ {"name": "firefox", "args": ["{browser}", "{uri}"] }
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
