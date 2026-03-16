local servers = {
  ansiblels = {},
  bashls = {},
  cssmodules_ls = {},
  dockerls = {},
  gopls = {},
  html = {},
  jsonnet_ls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        telemetry = {
          enabled = false,
        },
        workspace = {
          checkThirdParty = false,
        },
      },
    },
  },
  pyrefly = {},
  ruff = {},
  starpls = {},
  terraformls = {},
  tflint = {},
  yamlls = {},
}

local mason_extra_tools = {
  "black",
  "goimports",
  "hadolint",
  "isort",
  "prettierd",
  "stylua",
}

return {
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "Saghen/blink.cmp",
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local lsp = require("config.lsp")
      local ensure_installed = vim.tbl_keys(servers)

      vim.list_extend(ensure_installed, { "jdtls", "rust_analyzer" })

      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_enable = false,
      })

      lsp.setup()

      for server_name, server_opts in pairs(servers) do
        vim.lsp.config(server_name, vim.tbl_deep_extend("force", lsp.defaults(), server_opts))
        vim.lsp.enable(server_name)
      end
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    opts = {
      ensure_installed = vim.list_extend(vim.tbl_keys(servers), mason_extra_tools),
      auto_update = false,
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 12,
      integrations = {
        ["mason-lspconfig"] = true,
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    dependencies = {
      "Saghen/blink.cmp",
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local lsp = require("config.lsp")

      require("typescript-tools").setup(vim.tbl_deep_extend("force", lsp.defaults(), {
        settings = {
          publish_diagnostic_on = "insert_leave",
          separate_diagnostic_server = true,
          tsserver_max_memory = 8192,
        },
      }))
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    init = function()
      local lsp = require("config.lsp")

      vim.g.rustaceanvim = {
        server = vim.tbl_deep_extend("force", lsp.defaults(), {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
              completion = {
                postfix = {
                  enable = false,
                },
              },
              checkOnSave = {
                command = "clippy",
              },
              diagnostic = {
                refreshSupport = false,
              },
            },
          },
        }),
      }
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },
}
