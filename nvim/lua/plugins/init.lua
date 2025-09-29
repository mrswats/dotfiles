return {
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },
    {
        "tpope/vim-repeat",
        keys = { "." },
        event = "BufRead",
    },
    {
        "chaoren/vim-wordmotion",
        event = "BufRead",
    },
    {
        "christoomey/vim-sort-motion",
        config = function()
            vim.g.sort_motion_flags = "ui"
        end,
        event = "BufRead",
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end,
        event = "BufRead",
    },
    {
        "aserowy/tmux.nvim",
        opts = {
            copy_sync = {
                enable = false,
            },
            navigation = {
                cycle_navigation = false,
                enable_default_keybindings = true,
            },
        },
    },
    {
        "preservim/vimux",
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
        "akinsho/git-conflict.nvim",
        tag = "v1.3.0",
        opts = {
            default_mappings = false,
            default_commands = false,
        },
    },
    {
        "mvllow/modes.nvim",
        version = "v0.2.0",
        event = "BufRead",
        config = function()
            require("modes").setup()
        end,
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>do", "<cmd>DiffviewOpen<CR>" },
            { "<leader>dq", "<cmd>DiffviewClose<CR>" },
            { "<leader>dh", "<cmd>DiffviewFileHistory<CR>" },
        },
    },
    {
        "numToStr/Comment.nvim",
        opts = { ignore = "^$" },
        keys = {
            { "gcc" },
            { "gc", mode = "v" },
        },
    },
    {
        "m4xshen/autoclose.nvim",
        opts = {},
        event = "BufRead",
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({})
        end,
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },
}
