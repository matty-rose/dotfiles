let mapleader = "\<Space>"

let g:ale_disable_lsp = 1

" ====================
"       Plugins
" ====================
call plug#begin('~/.vim/plugged')

" LSP + Autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'ray-x/lsp_signature.nvim'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Linting + Formatting
Plug 'dense-analysis/ale'

" Syntax/code specific
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground'
Plug 'hashivim/vim-terraform' " seems to be only way for autoindent
Plug 'alx741/vim-stylishask'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Colors
Plug 'chriskempson/base16-vim'

" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'andymass/vim-matchup'
Plug 'terryma/vim-expand-region'
Plug 'Yggdroot/indentLine'
Plug 'windwp/nvim-autopairs'

" For Git blame
Plug 'tpope/vim-fugitive'

" Git [n ]n to move between merge conflict markers
Plug 'tpope/vim-unimpaired'

" Navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'psliwka/vim-smoothie'

" Fuzzy Finding
Plug 'airblade/vim-rooter'

" Fancy Startup
Plug 'mhinz/vim-startify'

" Todo
Plug 'folke/todo-comments.nvim'

" Utils
Plug 'nvim-lua/plenary.nvim'

call plug#end()

" ========================================
"             Configuration
" ========================================
" Show command
set showcmd

" Line numbering
set number
set relativenumber
set numberwidth=1
set cursorline

" Highlight matching brace
set showmatch

" Sane splitting
set splitright
set splitbelow

" Wild menu
set wildmenu
set wildmode=list:longest

" Don't show mode
set noshowmode

" Don't show no write since last change when changing buffers without save
set hidden

" No extra space when joining lines ending with .?!
set nojoinspaces

" Remove included files from completion
set complete-=i

" Proper searching
set incsearch " Highlight search as typing
set ignorecase
set smartcase

" Explicitly set read files open in vim that have been changed outside
set autoread

" Colour Scheme
syntax enable
set termguicolors
colorscheme base16-monokai

" Buffer status line
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1
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
let g:ale_linters = {
            \ 'javascript': ['eslint'], 
            \ 'typescript': ['eslint'], 
            \ 'python': ['flake8', 'mypy'], 
            \ 'go': ['golangci-lint'],
            \ 'dockerfile': ['hadolint'], 
            \ 'terraform': ['tflint'],
            \ 'rust': ['rls'],
            \ 'haskell': ['hlint']
            \ }
let g:ale_fixers = {
            \ 'python': ['black', 'isort'], 
            \ 'go': ['goimports'], 
            \ 'hcl': ['terraform'],
            \ 'javascript': ['prettier'], 
            \ 'typescript': ['prettier'], 
            \ 'yaml': ['prettier'], 
            \ 'terraform': ['terraform'],
            \ 'rust': ['rustfmt'],
            \ 'haskell': ['hindent']
            \ }
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Ale python
let g:ale_python_flake8_options = "--max-line-length 88"

" Ale golang
let g:ale_go_golangci_lint_options = ""

" Better message display
set cmdheight=2

" Update time
set updatetime=300

" Code column length
set colorcolumn=88

" Mute bell
set vb t_vb=

" =====================================
"         Keyboard Shortcuts
" =====================================

" Move between wrapped lines, rather than jumping over wrapped segments
nmap j gj
nmap k gk

" Quick save
nmap <leader>w :w<CR>

" Run python code
au FileType python map <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
au FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>

" Very magic modifier on search by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Auto center search results
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" <leader><leader> toggles between most recently used buffers
nnoremap <leader><leader> <c-^>

" Open
map <C-p> :lua require'matt.telescope'.find_files()<CR>
nmap <leader>; :Telescope buffers<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fh :Telescope help_tags<CR>

" ; as : in normal mode so no shift needed
nnoremap ; :

" stop searching
vnoremap <leader>h :nohlsearch<CR>
nnoremap <leader>h :nohlsearch<CR>

" start/end of line with home row
map H ^
map L $

" change Y behaviour to match others
map Y y$

" Break line shortcut (overrides some man command)
nnoremap K i<CR><Esc>

" Join line with folds and keep cursor
nnoremap J mzJ`z

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" replace up to next _
nnoremap <leader>m ct_

" vim expand region selecting
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Jump to end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Git merge conflict selects
nnoremap gdh :diffget 1<CR>
nnoremap gdl :diffget 3<CR>

" Compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" Copy to clipboard
nnoremap <leader>y "*y
vnoremap <leader>y "*y
nnoremap <leader>Y gg"*yG

" Breakpoints for undoing
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

" Move text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==

" ===============================
"         Autocommands
" ===============================

" Jump to last edit position on file open
if has("autocmd")
    au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Help Filetype detection
au BufRead *.md set filetype=markdown
au BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform

" Filetype Specific options
au FileType markdown let g:indentLine_setConceal=0
au FileType tf setlocal shiftwidth=2 softtabstop=2

" ========================================
"                   LUA
" ========================================

lua require("matt")
