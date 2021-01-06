let mapleader = "\<Space>"

" Ale stuff - must happen before plugins
let g:ale_disable_lsp = 1

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
Plug 'andymass/vim-matchup'

" Semantic Language Support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

" Git Management
Plug 'tpope/vim-fugitive'

" Syntax Stuff
Plug 'stephpy/vim-yaml'

" Fuzzy Finding
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()


" Show command
set showcmd

" Line numbering
set number
set numberwidth=1
set cursorline

" Highlight matching brace
set showmatch

" Sane splitting
set splitright
set splitbelow

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
let g:airline#extensions#ale#enabled = 1

" Spaces and tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set copyindent

" Permanent Undo
set undodir=~/.vimdid
set undofile

" Ale
let g:ale_linters = {'javascript': ['prettier', 'eslint'], 'python': ['flake8'], 'go': ['golint']}
let g:ale_linters_explicit = 1
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Better message display
set cmdheight=2

" Update time
set updatetime=300

" =====================================
"         Keyboard Shortcuts
" =====================================

" Quick save
nmap <leader>w :w<CR>

" Run python code
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>

" Very magic modifier on search by default
nnoremap ? ?\v
nnoremap / /\v

" GoTo code nav
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" <leader><leader> toggles between most recently used buffers
nnoremap <leader><leader> <c-^>

" Open
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" ===============================
"         Autocommands
" ===============================

" Add missing go imports on save
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" Jump to last edit position on file open
if has("autocmd")
    au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Help Filetype detection
autocmd BufRead *.md set filetype=markdown
