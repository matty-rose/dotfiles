require("matt.treesitter")
require("matt.blink")
require("matt.nvim_lsp")
require("matt.todo-comments")
require("matt.lualine")
require("matt.fzf-lua")
require("neoscroll").setup()
require("debugprint").setup()
require("fidget").setup()
require('distant').setup({
  -- Applies Chip's personal settings to every machine you connect to
  --
  -- 1. Ensures that distant servers terminate with no connections
  -- 2. Provides navigation bindings for remote directories
  -- 3. Provides keybinding to jump into a remote file's parent directory
  ['*'] = require('distant.settings').chip_default()
})

vim.lsp.set_log_level("off")

vim.highlight.priorities.semantic_tokens = 95
