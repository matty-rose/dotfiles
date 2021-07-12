let mapleader = "\<Space>"

" Ale stuff - must happen before plugins
let g:ale_disable_lsp = 1

" ====================
"       Plugins
" ====================
call plug#begin('~/.vim/plugged')

" Syntax/code specific
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'hashivim/vim-terraform' " seems to be only way for autoindent
Plug 'alx741/vim-stylishask'
Plug 'broadinstitute/vim-wdl'

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

" For Git blame
Plug 'tpope/vim-fugitive'

" Git [n ]n to move between merge conflict markers
Plug 'tpope/vim-unimpaired'

" Navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'psliwka/vim-smoothie'

" Semantic Language Support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

" Fuzzy Finding
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Fancy Startup
Plug 'mhinz/vim-startify'


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

" Fzf options
let g:fzf_layout = { 'down': '~20%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

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
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" GoTo code nav
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation in preview window
nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h '.expand('<cword')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" <leader><leader> toggles between most recently used buffers
nnoremap <leader><leader> <c-^>

" Open
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" Smart navigation? - tab for trigger completion
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc#on_enter() adds the spacing when CR after brackets Coc only does snippet and additional edit on confirm.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Left and right arrows can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" coc rename symbols
nmap <leader>rn <Plug>(coc-rename)

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

" Move to next ale lint error
nmap <silent> <C-e> <Plug>(ale_next_wrap)

" ===============================
"         Autocommands
" ===============================

" Jump to last edit position on file open
if has("autocmd")
    au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Help Filetype detection
au BufRead *.md set filetype=markdown
au BufRead,BufNewFile *.hcl set filetype=hcl
au BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform

" Filetype Specific options
au FileType markdown let g:indentLine_setConceal=0
au FileType tf setlocal shiftwidth=2 softtabstop=2

" Put linting status in bar
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
set statusline+=%=
set statusline+=\ %{LinterStatus()}

" ========================================
"               Tree-sitter
" ========================================

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { 
    "bash", 
    "c", 
    "dockerfile", 
    "fish", 
    "go", 
    "gomod", 
    "hcl", 
    "html", 
    "javascript", 
    "json", 
    "jsonc", 
    "lua", 
    "python", 
    "ruby", 
    "rust", 
    "toml", 
    "typescript", 
    "yaml" 
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  }
}
EOF
