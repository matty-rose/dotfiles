return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    opts = {
      notify_on_error = true,
      notify_no_formatters = false,
      format_on_save = function()
        return {
          timeout_ms = 1500,
          lsp_format = "fallback",
        }
      end,
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
        hcl = { "terraform_fmt" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonnet = { "jsonnetfmt" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        terraform = { "terraform_fmt" },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        dockerfile = { "hadolint" },
        terraform = { "tflint" },
      }

      local group = vim.api.nvim_create_augroup("NvimLint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = group,
        callback = function(args)
          if vim.bo[args.buf].buftype == "" then
            lint.try_lint()
          end
        end,
      })
    end,
  },
  {
    "Canva/dprint-vim-plugin",
    ft = {
      "javascript",
      "javascriptreact",
      "json",
      "markdown",
      "typescript",
      "typescriptreact",
      "yaml",
    },
  },
}
