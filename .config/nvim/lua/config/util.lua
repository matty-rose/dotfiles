local M = {}

local root_markers = {
  ".git",
  "package.json",
  ".pre-commit-config.yaml",
  "commitlint.config.js",
}

function M.project_root(bufnr)
  bufnr = bufnr or 0

  local path = vim.api.nvim_buf_get_name(bufnr)
  if path == "" then
    return (vim.uv or vim.loop).cwd()
  end

  return vim.fs.root(path, root_markers) or vim.fs.dirname(path) or (vim.uv or vim.loop).cwd()
end

return M
