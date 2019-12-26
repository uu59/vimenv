call plug#begin($XDG_CONFIG_HOME . '/vim/plugged')

Plug 'https://github.com/rhysd/committia.vim'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/LeafCage/yankround.vim'
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/godlygeek/tabular'
Plug 'https://github.com/vim-scripts/sudo.vim'
Plug 'https://github.com/airblade/vim-rooter'
Plug 'https://github.com/osyo-manga/vim-anzu'
Plug 'https://github.com/itchyny/lightline.vim'
Plug 'https://github.com/uu59/vim-emoji'
Plug 'https://github.com/thinca/vim-ref'

" Transform URL to markdown form with page title (See init.vim)
Plug 'https://github.com/mattn/webapi-vim'
Plug 'https://github.com/kana/vim-operator-user'

Plug 'https://github.com/kana/vim-submode'
Plug 'https://github.com/tyru/open-browser.vim'
Plug 'https://github.com/mhinz/vim-signify'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/vim-scripts/Rename'
Plug 'https://github.com/rhysd/conflict-marker.vim'
Plug 'https://github.com/haya14busa/vim-easymotion'
Plug 'https://github.com/mbbill/undotree'
Plug 'https://github.com/cocopon/colorswatch.vim', {'on': 'ColorSwatchGenerate'}
Plug 'https://github.com/rhysd/try-colorscheme.vim'
Plug 'https://github.com/mattn/benchvimrc-vim'

" colorscheme
Plug 'https://github.com/dracula/vim', {'as': 'dracula-vim'}
Plug 'https://github.com/chriskempson/tomorrow-theme', {'rtp': 'vim'}
Plug 'https://github.com/jonathanfilip/vim-lucius'
Plug 'https://github.com/trapd00r/neverland-vim-theme'
Plug 'https://github.com/bluntpeak/bluntpeak-vim-colors'
Plug 'https://github.com/ricardovaleriano/vim-github-theme'
Plug 'https://github.com/w0ng/vim-hybrid'
Plug 'https://github.com/thinkpixellab/flatland', {'rtp': 'Vim'}
Plug 'https://github.com/sonph/onehalf', {'rtp': 'vim'}

" lint tool
" Plug 'https://github.com/osyo-manga/vim-watchdogs'
" Plug 'https://github.com/osyo-manga/shabadou.vim'
Plug 'https://github.com/w0rp/ale'
Plug 'https://github.com/thinca/vim-quickrun'
Plug 'https://github.com/cohama/vim-hier'
Plug 'https://github.com/dannyob/quickfixstatus'

" ctrlp
Plug 'https://github.com/junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin --xdg' }

" waiting to be merged: https://github.com/tracyone/fzf-funky/pull/2
"Plug 'https://github.com/tracyone/fzf-funky'
Plug 'https://github.com/uu59/fzf-funky',  {'branch': 'respect_fzf_setting'}

" syntax
Plug 'https://github.com/cespare/vim-toml', {'for': 'toml'}
Plug 'https://github.com/kchmck/vim-coffee-script', {'for': 'coffee'}
Plug 'https://github.com/othree/html5.vim', {'for': 'html'}
Plug 'https://github.com/hail2u/vim-css3-syntax', {'for': 'css'}
Plug 'https://github.com/othree/yajs.vim', {'for': 'javascript'}
Plug 'https://github.com/othree/es.next.syntax.vim', {'for': 'javascript'}
Plug 'https://github.com/mxw/vim-jsx', {'for': 'javascript'}
Plug 'https://github.com/zaiste/tmux.vim', {'for': 'tmux'}
Plug 'https://github.com/slim-template/vim-slim', {'for': 'slim'}
Plug 'https://github.com/tpope/vim-haml', {'for': 'haml'}
Plug 'https://github.com/vim-scripts/PKGBUILD', {'for': 'pkgbuild'}
Plug 'https://github.com/wavded/vim-stylus', {'for': 'stylus'}
Plug 'https://github.com/ekalinin/Dockerfile.vim', {'for': 'dockerfile'}
Plug 'https://github.com/digitaltoad/vim-pug', {'for': 'jade'}
Plug 'https://github.com/b4b4r07/vim-hcl'
Plug 'https://github.com/chr4/nginx.vim'


if has('nvim')
  Plug 'https://github.com/glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
endif

call plug#end()
