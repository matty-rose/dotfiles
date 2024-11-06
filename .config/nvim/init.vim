let mapleader = "\<Space>"

let g:ale_disable_lsp = 1

" ====================
"       Plugins
" ====================
call plug#begin('~/.vim/plugged')

" LSP + Autocomplete
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'ray-x/lsp_signature.nvim'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make', 'branch': 'main' }

" Linting + Formatting
Plug 'dense-analysis/ale'

" Syntax/code specific
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground'
Plug 'hashivim/vim-terraform' " seems to be only way for autoindent
Plug 'alx741/vim-stylishask'
Plug 'mrcjkb/rustaceanvim', { 'version': '^4', 'lazy': 'false' }
Plug 'weihanglo/polar.vim'
Plug 'google/vim-jsonnet'
Plug 'pmizio/typescript-tools.nvim'
Plug 'mfussenegger/nvim-jdtls'

" Statusline
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Colors
Plug 'chriskempson/base16-vim'

" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'andymass/vim-matchup'
Plug 'terryma/vim-expand-region'
Plug 'Yggdroot/indentLine'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'

" For Git blame
Plug 'tpope/vim-fugitive'

" Git [n ]n to move between merge conflict markers
Plug 'tpope/vim-unimpaired'

" Navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'karb94/neoscroll.nvim'

" Fuzzy Finding
Plug 'airblade/vim-rooter'

" Fancy Startup
Plug 'mhinz/vim-startify'

" Todo
Plug 'folke/todo-comments.nvim'

" Utils
Plug 'nvim-lua/plenary.nvim'

" Remote Editing
Plug 'chipsenkbeil/distant.nvim', { 'branch': 'v0.2' }

" Canva Formatting
Plug 'Canva/dprint-vim-plugin'

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
            \ 'javascriptreact': ['eslint'], 
            \ 'typescriptreact': ['eslint'], 
            \ 'python': ['flake8', 'mypy'], 
            \ 'go': ['golangci-lint'],
            \ 'dockerfile': ['hadolint'], 
            \ 'terraform': ['tflint'],
            \ 'rust': ['rust_analyzer'],
            \ 'haskell': ['hlint']
            \ }
let g:ale_fixers = {
            \ 'python': ['black', 'isort'], 
            \ 'go': ['goimports'], 
            \ 'hcl': ['terraform'],
            \ 'javascript': ['prettier'], 
            \ 'typescript': ['prettier'], 
            \ 'javascriptreact': ['prettier'], 
            \ 'typescriptreact': ['prettier'], 
            \ 'yaml': ['prettier'], 
            \ 'terraform': ['terraform'],
            \ 'rust': ['rustfmt'],
            \ 'haskell': ['hindent'],
            \ 'json': ['prettier']
            \ }
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Ale python
let g:ale_python_flake8_options = "--max-line-length 100"

" Ale golang
let g:ale_go_golangci_lint_options = ""
let g:ale_go_golangci_lint_package = 1

" Better message display
set cmdheight=2

" Update time
set updatetime=300

" Code column length
set colorcolumn=100

" Mute bell
set vb t_vb=

" Completion
" Better completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" No Makefile for root
let g:rooter_patterns = ['!=theme', 'package.json', '.git', '.pre-commit-config.yaml', 'commitlint.config.js']

" Jsonnet Formatting
let g:jsonnet_fmt_options = '--string-style d --comment-style s --in-place'

" Dprint
let g:dprint_format_on_save = 1

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
au BufRead *.md,*.mdx set filetype=markdown
au BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform

" Filetype Specific options
au FileType markdown let g:indentLine_setConceal=0
au FileType json let g:indentLine_setConceal=0
au FileType tf setlocal shiftwidth=2 softtabstop=2
au FileType yaml setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
au FileType javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
au FileType typescript setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
au FileType typescriptreact setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
au Filetype go setlocal colorcolumn=120
au Filetype rust setlocal colorcolumn=100
au FileType yaml let g:ale_javascript_prettier_options = "--tab-width 2 --single-quote false"

" Highlight yanked text
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END

" ========================================
"                   LUA
" ========================================

lua require("matt")
