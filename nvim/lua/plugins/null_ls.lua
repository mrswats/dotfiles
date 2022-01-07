local M = {}

local function on_attach()
    local nest = require("nest")
    nest.applyKeymaps({
        buffer = true,
        options = {
            noremap = true,
            silent = true,
        },
        {
            { "]d", "<cmd> Lspsaga diagnostic_jump_next<CR>" },
            { "[d", "<cmd> Lspsaga diagnostic_jump_prev<CR>" },
        },
    })
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
end

local function register_null_ls_sources()
    local null_ls = require("null-ls")
    local sources = {
        -- Python
        null_ls.builtins.diagnostics.flake8.with({
            command = vim.fn.expand("$HOME/.local/bin/flake8"),
        }),
        null_ls.builtins.diagnostics.mypy.with({
            command = vim.fn.expand("$HOME/.local/bin/mypy"),
            extra_args = { "--config-file", vim.fn.expand("$DOTFILES/python/mypy.ini") },
        }),
        null_ls.builtins.formatting.isort.with({

            command = vim.fn.expand("$HOME/.local/bin/isort"),
        }),
        null_ls.builtins.formatting.black.with({

            command = vim.fn.expand("$HOME/.local/bin/black"),
        }),
        -- Lua
        null_ls.builtins.diagnostics.selene.with({
            extra_args = { "--config", vim.fn.expand("$DOTFILES/selene.toml") },
        }),
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.shfmt.with({ filetypes = { "sh", "zsh" } }),
        null_ls.builtins.diagnostics.yamllint.with({
            extra_args = { "-c", vim.fn.expand("$DOTFILES/python/yamllint.yml") },
        }),
        -- Javascript
        null_ls.builtins.formatting.stylelint,
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.formatting.prettierd,
        -- Golang
        null_ls.builtins.formatting.gofmt,
        -- Rust
        null_ls.builtins.formatting.rustfmt,
        -- Shell
        null_ls.builtins.diagnostics.shellcheck,
        -- Common
        null_ls.builtins.formatting.trim_newlines,
        null_ls.builtins.formatting.trim_whitespace,
    }

    null_ls.setup({
        sources = sources,
        on_attach = on_attach,
        handlers = {
            ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                underline = false,
                virtual_text = false,
                signs = true,
                update_in_insert = false,
            }),
        },
    })
end

function M.setup()
    register_null_ls_sources()
end

return M
