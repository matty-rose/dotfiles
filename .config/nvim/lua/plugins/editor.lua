return {
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "terryma/vim-expand-region",
    event = "VeryLazy",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "▏",
      },
      scope = {
        enabled = false,
      },
      exclude = {
        filetypes = {
          "alpha",
          "dashboard",
          "help",
          "json",
          "lazy",
          "markdown",
        },
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        multiline = true,
        multiline_pattern = "^.",
        multiline_context = 10,
        before = "",
        keyword = "bg",
        after = "fg",
        pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:]],
        comments_only = true,
        max_line_len = 400,
        exclude = {},
      },
      signs = false,
      search = {
        pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
      },
    },
  },
  {
    "andrewferrier/debugprint.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
