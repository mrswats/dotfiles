return {
    "metalelf0/black-metal-theme-neovim",
    priority = 1000,
    lazy = false,
    config = function()
        require("black-metal").setup({
            theme = "emperor",
            alt_bg = true,
            favor_treesitter_hl = true,
        })
        vim.cmd("colorscheme kanso")
    end,
}
