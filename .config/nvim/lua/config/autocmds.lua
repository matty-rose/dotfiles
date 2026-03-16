local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local function set_gitsigns_highlights()
  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#98c379" })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#e5c07b" })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#e06c75" })
  vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = "#e06c75" })
  vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#d19a66" })
end

autocmd("BufWritePre", {
  group = augroup("TrimWhitespace", { clear = true }),
  callback = function(args)
    if vim.bo[args.buf].modifiable == false or vim.bo[args.buf].buftype ~= "" then
      return
    end

    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

autocmd("BufReadPost", {
  group = augroup("RestoreCursor", { clear = true }),
  callback = function(args)
    local excluded = "/%.git/"
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    local file_path = vim.api.nvim_buf_get_name(args.buf)

    if file_path:match(excluded) then
      return
    end

    if mark[1] > 1 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd("FileType", {
  group = augroup("PythonRunner", { clear = true }),
  pattern = "python",
  callback = function(args)
    local run_current_file = function()
      vim.cmd.write()
      vim.system({ "python", vim.api.nvim_buf_get_name(args.buf) }):wait()
    end

    vim.keymap.set({ "n", "i" }, "<f9>", function()
      if vim.api.nvim_get_mode().mode:sub(1, 1) == "i" then
        vim.cmd.stopinsert()
      end
      run_current_file()
    end, { buffer = args.buf, silent = true, desc = "Run current Python file" })
  end,
})

autocmd("FileType", {
  group = augroup("EditorLocalSettings", { clear = true }),
  pattern = { "terraform", "yaml", "javascript", "typescript", "typescriptreact", "javascriptreact", "go", "rust" },
  callback = function(args)
    local opt_local = vim.opt_local

    if args.match == "terraform" then
      opt_local.shiftwidth = 2
      opt_local.softtabstop = 2
      opt_local.tabstop = 2
      return
    end

    if args.match == "yaml" or args.match == "javascript" or args.match == "typescript" or args.match == "typescriptreact" or args.match == "javascriptreact" then
      opt_local.shiftwidth = 2
      opt_local.softtabstop = 2
      opt_local.tabstop = 2
      opt_local.expandtab = true
      return
    end

    if args.match == "go" then
      opt_local.colorcolumn = "120"
      return
    end

    if args.match == "rust" then
      opt_local.colorcolumn = "100"
    end
  end,
})

autocmd("TextYankPost", {
  group = augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

autocmd("FileType", {
  group = augroup("TreeSitterHighlight", { clear = true }),
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

autocmd("ColorScheme", {
  group = augroup("ClearLspSemanticHighlights", { clear = true }),
  callback = function()
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end

    set_gitsigns_highlights()
  end,
})

set_gitsigns_highlights()
