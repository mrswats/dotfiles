return {
    "lukas-reineke/indent-blankline.nvim",
    tag = "v3.8.2",
    opts = {
        indent = {
            char = "│",
            tab_char = "│",
        },
        scope = { enabled = false },
        exclude = {
            filetypes = { "help", "alpha", "NvimTree", "lazy" },
        },
    },
    main = "ibl",
}
