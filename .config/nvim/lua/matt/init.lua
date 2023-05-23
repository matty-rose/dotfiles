require("matt.autopairs")
require("matt.treesitter")
require("matt.nvim_lsp")
require("matt.nvim-cmp")
require("matt.telescope")
require("matt.todo-comments")
require("matt.lualine")
require("matt.rust-tools")
require("neoscroll").setup()
require('distant').setup({
  -- Applies Chip's personal settings to every machine you connect to
  --
  -- 1. Ensures that distant servers terminate with no connections
  -- 2. Provides navigation bindings for remote directories
  -- 3. Provides keybinding to jump into a remote file's parent directory
  ['*'] = require('distant.settings').chip_default()
})
