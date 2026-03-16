return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local languages = {
        "bash",
        "c",
        "dockerfile",
        "fish",
        "go",
        "gomod",
        "gowork",
        "hcl",
        "html",
        "java",
        "javascript",
        "json",
        "jsonnet",
        "lua",
        "make",
        "python",
        "ruby",
        "rust",
        "toml",
        "typescript",
        "yaml",
      }

      require("nvim-treesitter.install").compilers = { "gcc" }
      require("nvim-treesitter").setup()
      require("nvim-treesitter").install(languages)
    end,
  },
  {
    "hashivim/vim-terraform",
    ft = { "terraform", "hcl" },
  },
  {
    "google/vim-jsonnet",
    ft = { "jsonnet", "libsonnet" },
  },
}
