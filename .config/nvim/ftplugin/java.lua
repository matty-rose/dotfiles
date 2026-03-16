local status, jdtls = pcall(require, "jdtls")
if not status then
  return
end

local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/jdtls-workspace"
local root_markers = { ".git", "gradlew", "mvnw", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if not root_dir then
  return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = workspace_path .. "/" .. project_name

local os_config = "linux"
if vim.fn.has "mac" == 1 then
  os_config = "mac"
end

local lsp = require("config.lsp")
local capabilities = lsp.capabilities()
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
local mason_root = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local launcher = vim.fn.glob(mason_root .. "/plugins/org.eclipse.equinox.launcher_*.jar")
if launcher == "" then
  return
end

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms4g",
    "-Xmx16g",
    "-XX:+UseParallelGC",
    "-XX:GCTimeRatio=4",
    "-XX:AdaptiveSizePolicyWeight=90",
    "-Dsun.zip.disableMemoryMapping=true",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. mason_root .. "/lombok.jar",
    "-jar",
    launcher,
    "-configuration",
    mason_root .. "/config_" .. os_config,
    "-data",
    workspace_dir,
  },
  on_attach = lsp.on_attach,
  capabilities = capabilities,
  root_dir = root_dir,
  settings = {
    java = {
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-17",
            path = vim.fn.expand('/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home'),
          },
        },
      },
      autobuild = {
        enabled = true,
      },
      maven = {
        downloadSources = true,
        updateSnapshots = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all", -- literals, all, none
        },
      },
      format = {
        enabled = false,
      },
      import = {
        exclusions = {
          "**",
          "**/bazel-bin/**",
          "**/bazel-links/**",
          "**/bazel-out/**",
          "**/bazel-testlogs/**",
          "**/node_modules/**",
        },
      },
      project = {
        resourceFilters = { "node_modules", ".metadata", "META-INF/maven", "bazel-bin", "bazel-links", "bazel-out", "bazel-testlogs" },
      },
      maxConcurrentBuilds = 5,
    },
    signatureHelp = { enabled = true },
    extendedClientCapabilities = extendedClientCapabilities,
  },
  flags = {
    allow_incremental_sync = true,
  },
}

require("jdtls").start_or_attach(config)
