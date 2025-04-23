return {
    "metalelf0/black-metal-theme-neovim",
    priority = 1000,
    lazy = false,
    config = function()
        require("black-metal").setup()
        vim.cmd("colorscheme emperor")
    end,
}
