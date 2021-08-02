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
    disable = { 'yaml' },
  }
}
