return {
    "navarasu/onedark.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        require("onedark").setup({
            style = "deep",
        })
        require("onedark").load()
    end,
}
