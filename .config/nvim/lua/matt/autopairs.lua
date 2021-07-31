require("nvim-autopairs").setup()
require("nvim-autopairs.completion.compe").setup({
  map_cr = true, -- map <CR> on insert mode
  map_complete = true -- auto insert '(' after select function/method item
})
