require'nvim-treesitter.install'.compilers = { "gcc" }
require'nvim-treesitter.configs'.setup {
  ensure_installed = { 
    "bash", 
    "c", 
    "dockerfile", 
    "fish", 
    "go", 
    "gomod", 
    "gowork",
    "haskell",
    "hcl", 
    "html", 
    "javascript", 
    "json", 
    "jsonc", 
    "lua", 
    "make",
    "python", 
    "ruby", 
    "rust", 
    "toml", 
    "typescript", 
    "yaml",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { 'yaml' },
  }
}
