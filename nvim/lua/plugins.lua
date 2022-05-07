vim.cmd("packadd packer.nvim")

require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use({ "nvim-lua/plenary.nvim" })
    use({ "kyazdani42/nvim-web-devicons" })
    use({
        "nathom/filetype.nvim",
        config = function()
            require("filetype").setup({
                overrides = {},
            })
        end,
    })

    use({ "famiu/nvim-reload", cmd = "Reload" })

    use({ "LionC/nest.nvim" })

    use({
        "rmehri01/onenord.nvim",
        config = function()
            require("onenord").setup()
        end,
    })

    use({
        "goolord/alpha-nvim",
        config = function()
            require("plugins.alpha").setup()
        end,
    })

    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            require("plugins.statusline").setup()
        end,
        after = "nvim-web-devicons",
    })

    use({
        "rainbowhxch/beacon.nvim",
        config = function()
            require("beacon").setup({
                ignore_filetypes = { "alpha", "packer", "Trouble", "qf" },
            })
        end,
        event = "BufRead",
    })

    use({
        "yamatsum/nvim-cursorline",
        config = function()
            require("nvim-cursorline").setup({
                cursorline = {
                    enable = true,
                    timeout = 1000,
                    number = false,
                },
                cursorword = {
                    enable = true,
                    min_length = 3,
                    hl = { underline = true },
                },
            })
        end,
        event = "BufRead",
    })

    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                use_treesitter = true,
                filetype_exclude = { "alpha", "help", "man", "packer" },
            })
        end,
        event = { "BufRead" },
    })

    use({
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup({
                disable_netrw = true,
                view = {
                    width = 65,
                    side = "right",
                },
            })
        end,
        cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
    })

    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                disable_filetype = {
                    "vim",
                    "gitcommit",
                    "NeogitCommitMessage",
                },
                enable_check_bracket_line = false,
            })
        end,
        event = "InsertEnter",
    })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = {
            { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufRead" },
            { "windwp/nvim-ts-autotag", event = "BufRead" },
            { "p00f/nvim-ts-rainbow", event = "BufRead" },
        },
        config = function()
            require("plugins.treesitter").setup()
        end,
        event = { "BufRead" },
    })

    use({
        "chaoren/vim-wordmotion",
        event = "BufRead",
    })

    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.lsp").setup_lsp()
        end,
        after = "null_ls",
    })

    use({
        "jose-elias-alvarez/null-ls.nvim",
        as = "null_ls",
        event = "BufRead",
    })

    use({
        "rafamadriz/friendly-snippets",
        event = "InsertEnter",
    })

    use({
        "L3MON4D3/LuaSnip",
        after = "friendly-snippets",
        as = "luasnip",
    })

    use({
        "hrsh7th/nvim-cmp",
        config = function()
            require("plugins.cmp").setup()
        end,
        after = { "nvim-autopairs", "luasnip", "null_ls" },
    })

    use({
        "hrsh7th/cmp-nvim-lsp",
        after = "nvim-cmp",
    })

    use({
        "hrsh7th/cmp-buffer",
        after = "nvim-cmp",
    })

    use({
        "hrsh7th/cmp-path",
        after = "nvim-cmp",
    })

    use({
        "hrsh7th/cmp-cmdline",
        after = "nvim-cmp",
    })

    use({
        "andersevenrud/cmp-tmux",
        after = "nvim-cmp",
    })

    use({
        "hrsh7th/cmp-emoji",
        after = "nvim-cmp",
    })

    use({
        "saadparwaiz1/cmp_luasnip",
        after = "nvim-cmp",
    })

    use({
        "hrsh7th/cmp-nvim-lsp-signature-help",
        after = "nvim-cmp",
    })

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                position = "right",
                mode = "document_diagnostics",
            })
        end,
        cmd = { "Trouble", "TroubleToggle" },
    })

    use({ "kevinhwang91/nvim-bqf", ft = "qf" })

    use({
        "vim-test/vim-test",
        config = function()
            require("plugins.test").setup()
        end,
        cmd = { "TestFile", "TestNearest" },
    })

    use({
        "ibhagwan/fzf-lua",
        config = function()
            require("fzf-lua").setup({
                winopts = {
                    width = 0.87,
                },
            })
        end,
    })

    use({
        "rgroli/other.nvim",
        config = function()
            require("other-nvim").setup({
                mappings = {
                    {
                        pattern = "(.*)/(.*).jsx?",
                        target = "%1/%2.test.js",
                    },
                    {
                        pattern = "(.*)/(.*)_test.py",
                        target = "%1/%2.py",
                    },
                    {
                        pattern = "(.*)/test_(.*).py",
                        target = "%1/%2.py",
                    },
                    {
                        pattern = "(.*)/(.*).py",
                        target = "%1/\\(%2_test.py\\|test_%2.py\\)",
                    },
                },
            })
        end,
        cmd = { "OtherVSplit" },
    })

    use({
        "TimUntersberger/neogit",
        config = function()
            require("plugins.neogit").setup()
        end,
        cmd = "Neogit",
    })

    use({
        "pwntester/octo.nvim",
        config = function()
            require("octo").setup()
        end,
        cmd = "Octo",
    })

    use({
        "sindrets/diffview.nvim",
        config = function()
            require("diffview.config").setup()
        end,
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    })

    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.gitsigns").setup()
        end,
        event = { "BufRead" },
    })

    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({ ignore = "^$" })
        end,
        keys = { "gcc", { "v", "gc" } },
    })

    use({
        "christoomey/vim-sort-motion",
        config = function()
            vim.g.sort_motion_flags = "ui"
        end,
        keys = { "gs" },
    })

    use({
        "tpope/vim-abolish",
        keys = { "crm", "crc", "crs", "cru", "cr-", "cr.", "cr<space>", "crt" },
    })

    use({
        "tpope/vim-repeat",
        key = { "." },
        event = "BufRead",
    })

    use({
        "tpope/vim-surround",
        event = "BufRead",
    })

    use({
        "tpope/vim-unimpaired",
        event = "BufRead",
    })

    use({
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        run = "cd app && yarn install",
        cmd = "MarkdownPreview",
    })

    use({
        "benmills/vimux",
        config = function()
            require("plugins.vimux").setup()
        end,
        event = "BufRead",
    })

    use({
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup({
                copy_sync = {
                    enable = false,
                },
                navigation = {
                    cycle_navigation = false,
                    enable_default_keybindings = true,
                },
            })
        end,
    })
end)
