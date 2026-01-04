local function setup()
    vim.diagnostic.config({ virtual_text = false })
    -- Set up border for floating preview windows
    -- source: https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
    local border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
    }

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts.border = border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
            local opts = { noremap = true, silent = true, buffer = event.buf }
            local set_keymap = vim.keymap.set

            vim.api.nvim_buf_set_option(event.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")

            set_keymap("n", "gd", vim.lsp.buf.definition, opts)
            set_keymap("n", "gr", vim.lsp.buf.rename, opts)
            set_keymap("n", "gR", vim.lsp.buf.references, opts)
            set_keymap("n", "gq", vim.lsp.buf.format, opts)
            set_keymap("n", "K", vim.lsp.buf.hover, opts)
            set_keymap("n", "gl", vim.diagnostic.setloclist, opts)
        end,
    })

    vim.lsp.enable("cssls")
    vim.lsp.enable("djls")
    vim.lsp.enable("djlsp")
    vim.lsp.enable("html")
    vim.lsp.enable("ocamllsp")
    vim.lsp.enable("pylsp")
    vim.lsp.enable("tailwindcss")
    vim.lsp.enable("ts_ls")
end

return {
    "neovim/nvim-lspconfig",
    config = function()
        setup()
    end,
    event = "BufRead",
}
