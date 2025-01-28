require("matt.treesitter")
require("matt.blink")
require("matt.nvim_lsp")
require("matt.todo-comments")
require("matt.lualine")
require("matt.fzf-lua")
require("neoscroll").setup()
require("debugprint").setup()
require("fidget").setup()

vim.lsp.set_log_level("off")

vim.highlight.priorities.semantic_tokens = 95

-- removes trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})
