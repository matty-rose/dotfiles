" Plugins
call plug#begin('~/.vim/plugged')

" Syntax/code specific
Plug 'sheerun/vim-polyglot'
Plug 'alx741/vim-stylishask'

" UI and Statusline
Plug 'lifepillar/vim-solarized8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Git Management
Plug 'tpope/vim-fugitive'

call plug#end()

" Show command
set showcmd

" Line numbering
set number
set numberwidth=1
set cursorline

" Highlight matching brace
set showmatch

" Fuzzy File Finding
set path+=**
set wildmenu

" Colour Scheme
syntax enable
set t_Co=256
set background=dark
colorscheme solarized8
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1

" Buffer status line
let g:airline#extensions#tabline#enabled = 1

" Spaces and tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set copyindent

" Run python code
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>
