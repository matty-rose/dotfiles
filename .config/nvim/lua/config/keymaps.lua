local map = vim.keymap.set
local function toggle_inlay_hints()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
end

map("n", "j", "gj")
map("n", "k", "gk")

map("n", "<leader>w", "<cmd>write<cr>", { desc = "Write buffer" })

map("n", "?", "?\\v")
map("n", "/", "/\\v")
map("c", "%s/", "%sm/")

map("n", "n", "nzzzv", { silent = true })
map("n", "N", "Nzzzv", { silent = true })
map("n", "*", "*zz", { silent = true })
map("n", "#", "#zz", { silent = true })
map("n", "g*", "g*zz", { silent = true })

map("n", "<leader><leader>", "<c-^>", { desc = "Alternate buffer" })
map("n", ";", ":", { silent = false })
map({ "n", "v" }, "<leader>h", "<cmd>nohlsearch<cr>", { silent = true, desc = "Clear search highlight" })

map({ "n", "v", "o" }, "H", "^")
map({ "n", "v", "o" }, "L", "$")
map({ "n", "v" }, "Y", "y$")

map("n", "K", "i<cr><esc>", { desc = "Break line" })
map("n", "J", "mzJ`z", { desc = "Join line without moving cursor" })

map("n", "<leader>e", ':edit <C-R>=expand("%:p:h") . "/"<cr>', { silent = false, desc = "Edit adjacent file" })
map("n", "<leader>m", "ct_", { desc = "Change to next underscore" })

map("x", "v", "<Plug>(expand_region_expand)")
map("x", "<c-v>", "<Plug>(expand_region_shrink)")

map("x", "y", "y`]", { silent = true })
map("x", "p", "p`]", { silent = true })
map("n", "p", "p`]", { silent = true })

map("n", "gdh", "<cmd>diffget 1<cr>", { desc = "Take left diff" })
map("n", "gdl", "<cmd>diffget 3<cr>", { desc = "Take right diff" })

map({ "n", "v" }, "<leader>y", '"*y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", 'gg"*yG', { desc = "Yank buffer to clipboard" })
map("n", "<leader>ui", toggle_inlay_hints, { desc = "Toggle inlay hints" })

map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")

map("x", "J", ":move '>+1<cr>gv=gv", { silent = true, desc = "Move selection down" })
map("x", "K", ":move '<-2<cr>gv=gv", { silent = true, desc = "Move selection up" })
map("n", "<leader>j", ":move .+1<cr>==", { silent = true, desc = "Move line down" })
map("n", "<leader>k", ":move .-2<cr>==", { silent = true, desc = "Move line up" })
map("i", "<c-j>", "<esc>:move .+1<cr>==", { silent = true, desc = "Move line down" })
map("i", "<c-k>", "<esc>:move .-2<cr>==", { silent = true, desc = "Move line up" })
