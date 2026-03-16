local M = {}

local diagnostic_icons = {
  [vim.diagnostic.severity.ERROR] = "⤫",
  [vim.diagnostic.severity.WARN] = "⚠",
  [vim.diagnostic.severity.INFO] = "󰋼",
  [vim.diagnostic.severity.HINT] = "󰌵",
}

local function buf_map(bufnr, mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, {
    buffer = bufnr,
    silent = true,
    desc = desc,
  })
end

function M.capabilities()
  local ok, blink = pcall(require, "blink.cmp")
  if ok then
    return blink.get_lsp_capabilities()
  end

  return vim.lsp.protocol.make_client_capabilities()
end

function M.on_attach(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil

  if client.name == "ruff" then
    client.server_capabilities.hoverProvider = false
  end

  buf_map(bufnr, "n", "gD", vim.lsp.buf.declaration, "LSP declaration")
  buf_map(bufnr, "n", "gd", vim.lsp.buf.definition, "LSP definition")
  buf_map(bufnr, "n", "<leader>d", vim.lsp.buf.hover, "LSP hover")
  buf_map(bufnr, "n", "gi", vim.lsp.buf.implementation, "LSP implementation")
  buf_map(bufnr, "n", "<leader>dd", vim.lsp.buf.signature_help, "LSP signature help")
  buf_map(bufnr, "n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
  buf_map(bufnr, "n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
  buf_map(bufnr, "n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List workspace folders")
  buf_map(bufnr, "n", "<leader>D", vim.lsp.buf.type_definition, "LSP type definition")
  buf_map(bufnr, "n", "<leader>rn", vim.lsp.buf.rename, "LSP rename")
  buf_map(bufnr, "n", "<leader>ca", vim.lsp.buf.code_action, "LSP code action")
  buf_map(bufnr, "n", "gr", vim.lsp.buf.references, "LSP references")
  buf_map(bufnr, "n", "<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
  buf_map(bufnr, "n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
  buf_map(bufnr, "n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
  buf_map(bufnr, "n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics list")
  buf_map(bufnr, "n", "<leader>f", function()
    require("conform").format({ async = false, lsp_format = "fallback" })
  end, "Format buffer")
end

function M.defaults()
  return {
    capabilities = M.capabilities(),
    on_attach = M.on_attach,
  }
end

function M.setup()
  vim.lsp.set_log_level("off")
  vim.highlight.priorities.semantic_tokens = 95

  vim.diagnostic.config({
    severity_sort = true,
    virtual_text = {
      spacing = 2,
      source = "if_many",
    },
    float = {
      border = "rounded",
      source = "if_many",
    },
    signs = {
      text = diagnostic_icons,
    },
    update_in_insert = false,
  })
end

return M
