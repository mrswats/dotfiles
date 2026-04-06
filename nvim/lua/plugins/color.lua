return {
    "wurli/cobalt.nvim",
    event = { "ColorSchemePre" }, -- if you want to lazy load
    init = function()
        vim.cmd("colorscheme cobalt")
    end,
}
