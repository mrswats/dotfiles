return {
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "kyazdani42/nvim-web-devicons",
        lazy = true,
    },
    {
        "chaoren/vim-wordmotion",
        event = "BufRead",
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = "BufRead",
    },
    {
        "Almo7aya/openingh.nvim",
        cmd = { "OpenInGHFile", "OpenInGHRepo" },
    },
    {
        "tpope/vim-unimpaired",
        event = "BufRead",
    },
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        build = "cd app && yarn install",
        cmd = "MarkdownPreview",
    },
    {
        "eandrju/cellular-automaton.nvim",
        cmd = { "CellularAutomaton" },
    },
    {
        "akinsho/git-conflict.nvim",
        tag = "v1.3.0",
        opts = {
            default_mappings = false,
            default_commands = false,
        },
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                render = "wrapped-compact",
                stages = "static",
            })
            vim.notify = require("notify")
        end,
    },
}
