local function project_files()
    local fzf = require("fzf-lua")
    local root = require("config.util").project_root()

    fzf.files({
        cwd = root,
        cmd = table.concat({
            "rg",
            "--files",
            "--hidden",
            "-g",
            "!.git",
            "-g",
            "!bazel-bin/**",
            "-g",
            "!bazel-out/**",
            "-g",
            "!bazel-testlogs/**",
        }, " "),
    })
end

return {
    {
        "ibhagwan/fzf-lua",
        cmd = { "FzfLua" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<c-p>",     project_files,                               desc = "Find project files" },
            { "<leader>;", function() require("fzf-lua").buffers() end, desc = "Buffers" },
        },
        opts = {
            files = {
                git_icons = false,
            },
        },
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        opts = {},
    },
}
