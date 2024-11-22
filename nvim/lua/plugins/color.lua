return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            on_colors = function(colors)
                colors.comment = "#9aa5ce"
            end,
        })
        vim.cmd([[colorscheme tokyonight-storm]])
    end,
}
