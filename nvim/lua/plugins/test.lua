return {
    "vim-test/vim-test",
    config = function()
        vim.g["test#enabled_runner"] = { "python#pytest" }
        vim.g["test#strategy"] = "vimux"
        vim.g["test#python#runner"] = "pytest"
        vim.g["test#python#pytest#options"] = {
            nearest = "--color yes -lsxvv",
            file = "--color yes --durations=10 -qk ''",
            suite = "--color yes --durations=10 -qk ''",
        }
    end,
    cmd = { "TestFile", "TestNearest", "TestSuite" },
    keys = {
        { "<leader>tn", "<cmd>TestNearest<CR>" },
        { "<leader>tf", "<cmd>TestFile<CR>" },
        { "<leader>ts", "<cmd>TestSuite<CR>" },
    },
}
