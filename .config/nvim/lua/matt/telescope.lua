require("telescope").setup{
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = false,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
}

require("telescope").load_extension("fzf")

local M = {}
M.find_files = function()
    require("telescope.builtin").find_files({
        find_command = { 'rg', '--files', '--hidden', '-g', '!.git', '-g', '!bazel-bin/**', '-g', '!bazel-canva/**', '-g', '!bazel-out/**', '-g', '!bazel-testlogs/**'},
    })
end

return M
