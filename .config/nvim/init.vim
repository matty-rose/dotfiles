" ====================
"       Plugins
" ====================
call plug#begin('~/.vim/plugged')

" VIM enhancements
Plug 'justinmk/vim-sneak'

" Syntax/code specific
Plug 'sheerun/vim-polyglot'
Plug 'alx741/vim-stylishask'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Colors
Plug 'chriskempson/base16-vim'
" Plug 'lifepillar/vim-solarized8'
" Plug 'nightsense/carbonized'

" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Git Management
Plug 'tpope/vim-fugitive'

" Syntax Stuff
Plug 'stephpy/vim-yaml'

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
set termguicolors
colorscheme base16-monokai
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
