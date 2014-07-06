" /* vim: set fdm=marker: */

let g:tinyvim = 0

source $HOME/.vimrc.basic

" ### filetype setting ### {{{
augroup FileTypes
  autocmd!

  "au BufEnter * execute ":lcd" . expand("%:p:h")

  au BufEnter *.erubis   setlocal ft=eruby
  au BufEnter *.coffee   setlocal ft=coffee
  au BufEnter *.bats     setlocal ft=sh
  au BufEnter Gemfile    setlocal ft=ruby
  au BufEnter Rakefile   setlocal ft=ruby
  au BufEnter config.ru  setlocal ft=ruby
  au BufEnter *.md,*.mkd setlocal ft=markdown " .md is not modula2
  au BufEnter PKGBUILD   setlocal ft=sh

  au BufNewFile *.sh,*.bash execute "0r ~/.vim/template/bash.txt"
  \ | execute ":normal GV{{"

  au BufNewFile *.rb execute "0r ~/.vim/template/ruby.txt"
  \ | execute "10"

  au BufNewFile PKGBUILD execute "0r ~/.vim/template/PKGBUILD"

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
  au FileType text setlocal textwidth=0
augroup END
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
  colo Tomorrow-Night-Bright
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

nmap [Space]tw :<C-u>TweetVimHomeTimeline<CR><C-m>

" }}}

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
      \ 'command': 'github-markup'
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
noremap [Space]u :<C-u>Unite 
noremap [Space]b :<C-u>Unite buffer<CR>
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
let g:ctrlp_map = '[Space]f'
let g:ctrlp_arg_map = 1
let g:ctrlp_max_height = 12
let g:ctrlp_cache_dir = '/tmp/ctrlp'
if executable('find') == 1 && executable('grep') == 1 && executable('head') == 1
  let g:ctrlp_user_command =
    \ 'find %s -type f -o \( -name .git -o -name tmp -o -name .hg -name .svn \) -prune -type f' .
    \ '| head -1000' .
    \ '| grep -v -i -E "\.(jpe?g|png|gif|[ot]tf|ico)$"'
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
\     'line': 32,
\   },
\   'ej': {
\     'url': 'http://dictionary.goo.ne.jp/srch/ej/%s/m0u/',
\     'line': 32,
\   },
\   'alc': {
\     'url': 'http://eow.alc.co.jp/search?q=%s',
\     'line': 31,
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
\ }
nnoremap [Space]d :<C-u>Ref webdict 
let g:ref_source_webdict_use_cache = 0
" }}}

" -- syntastic.vim {{{
let g:syntastic_javascript_jshint_conf = "~/.vim/jshintrc"
let g:syntastic_error_symbol='⚔' " ☠ ✗ ☣ ☢
let g:syntastic_warning_symbol='⚐' " ☹  ⚠
" }}}

" -- VimShell {{{
"nnoremap <silent> [Space]s :<C-u>VimShell -popup<CR>
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
      \   'right': [ [ 'modified', 'absolutepath' ], [ 'filetype'], ['fileformat', 'fileencoding'] ],
      \ },
      \ 'inactive': {
      \   'left': [ ['mode'] ],
      \   'right': [ ['absolutepath' ], [ 'filetype'], ['fileformat', 'fileencoding'] ],
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

call submode#enter_with('fontsize', 'n', 'r', '\S+', '<Plug>FontsizeBegin')
call submode#enter_with('fontsize', 'n', 'r', '\S-', '<Plug>FontsizeBegin')
call submode#map('fontsize', 'n', 'r', '+', '<Plug>FontsizeInc')
call submode#map('fontsize', 'n', 'r', '-', '<Plug>FontsizeDec')
call submode#map('fontsize', 'n', 'r', '0', '<Plug>FontsizeDefault')
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

" wildfire.vim {{{
" This selects the next closest text object.
let g:wildfire_fuel_map = "<Enter>"

" This selects the previous closest text object.
let g:wildfire_water_map = "<S-Enter>"

" use '*' to mean 'all other filetypes'
" in this example, html and xml share the same text objects
let g:wildfire_objects = {
    \ '*' : ['i"', "i'", 'i)', 'i]'],
    \ "html,xml" : ["at"],
\ }
" }}}

" open-browser.vim {{{
let g:openbrowser_browser_commands = [
      \ {"name": "w3m", "args": ["{browser}", "{uri}"] },
      \ {"name": "firefox", "args": ["{browser}", "{uri}"] }
      \ ]
" }}}

" }}}

