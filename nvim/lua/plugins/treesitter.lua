return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        local treesitter = require("nvim-treesitter")
        local autotag = require("nvim-ts-autotag")

        treesitter.install({
            "bash",
            "c",
            "comment",
            "dockerfile",
            "editorconfig",
            "git_config",
            "gitignore",
            "go",
            "hcl",
            "html",
            "htmldjango",
            "hyprlang",
            "javascript",
            "json",
            "latex",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            "python",
            "rst",
            "rust",
            "ssh_config",
            "terraform",
            "tmux",
            "toml",
            "typescript",
            "yaml",
        })

        treesitter.setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        autotag.setup()
    end,
}
