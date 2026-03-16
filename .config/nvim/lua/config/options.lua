vim.g.python3_host_prog = "/Users/mattyrose/work/canva/tools/build/python/third_party/.venv/bin/python"
vim.g.jsonnet_fmt_options = "--string-style d --comment-style s --in-place"
vim.g.dprint_format_on_save = 0

vim.filetype.add({
  extension = {
    md = "markdown",
    mdx = "markdown",
    tf = "terraform",
    tfvars = "terraform",
  },
})

local opt = vim.opt

opt.showcmd = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 1
opt.cursorline = true
opt.showmatch = true
opt.splitright = true
opt.splitbelow = true
opt.wildmenu = true
opt.wildmode = "list:longest"
opt.showmode = false
opt.hidden = true
opt.joinspaces = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.autoread = true
opt.termguicolors = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.copyindent = true
opt.undodir = vim.fn.expand("~/.vimdid")
opt.undofile = true
opt.cmdheight = 2
opt.updatetime = 300
opt.colorcolumn = "100"
opt.visualbell = true
opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.signcolumn = "yes"

opt.complete:remove("i")
