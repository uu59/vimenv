set laststatus=0
set bg=light
colo onehalflight
set nonu
set guifont=Monospace:h10
set wrap
" バッファのチルダ非表示
hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
augroup firenvim
  autocmd!
  au BufEnter github.com_*.txt set filetype=markdown
augroup END

