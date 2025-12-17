local function setup()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.load_extension("fzf")
    telescope.load_extension("luasnip")

    telescope.setup({
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
        pickers = {
            git_files = {
                show_untracked = true,
            },
        },
        defaults = {
            mappings = {
                i = {
                    ["<c-j>"] = actions.move_selection_next,
                    ["<c-k>"] = actions.move_selection_previous,
                    -- source: https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#mapping-esc-to-quit-in-insert-mode
                    ["<esc>"] = actions.close,
                    ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
                    ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
                },
                n = {
                    ["<esc>"] = actions.close,
                    ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
                    ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
                },
            },
            file_ignore_patterns = { "node_modules", "%.git/" },
            prompt_prefix = " ",
            use_less = false,
            sorting_strategy = "ascending",
            selection_caret = "  ",
            entry_prefix = "  ",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                vertical = {
                    mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            path_display = { "truncate" },
            border = {},
            set_env = { ["COLORTERM"] = "truecolor" },
        },
    })
end

return {
    "nvim-telescope/telescope.nvim",
    config = function()
        setup()
    end,
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install",
        },
        {
            "benfowler/telescope-luasnip.nvim",
            module = "telescope._extensions.luasnip", -- if you wish to lazy-load
        },
    },
    keys = {
        { "<c-g><c-e>", "<cmd>Telescope git_files<CR>" },
        { "<c-g><c-s>", "<cmd>Telescope live_grep<CR>" },
        { "<c-g><c-b>", "<cmd>Telescope buffers<CR>" },
    },
    cmd = "Telescope",
}
