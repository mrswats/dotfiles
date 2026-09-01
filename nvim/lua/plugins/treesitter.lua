local parsers = {
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
    "toml",
    "typescript",
    "yaml",
}

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        require("nvim-treesitter").install(parsers)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = parsers,
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
