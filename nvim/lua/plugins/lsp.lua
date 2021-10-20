local nvim_lsp = require("lspconfig")

local M = {}

local function disable_virtual_text()
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            underline = true,
            virtual_text = false,
            signs = true,
            update_in_insert = false
        }
    )
end

local function on_attach(client, bufnr)
    local nest = require("nest")
    local kind = require("lspkind")
    local saga = require("lspsaga")
    local signature = require("lsp_signature")

    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- saga
    saga.setup(
        {
            error_sign = "",
            warn_sign = "",
            hint_sign = "",
            infor_sign = "",
            border_style = "round"
        }
    )

    -- lspkind
    kind.init()

    -- lsp signature
    signature.on_attach({use_lspsaga = false})

    -- Mappings.
    nest.applyKeymaps {
        buffer = true,
        options = {noremap = true, silent = true},
        {
            {
                "g",
                {
                    {"d", "<cmd>lua vim.lsp.buf.definition()<CR>"},
                    {"r", "<cmd> Lspsaga rename<CR>"},
                    {"R", "<cmd> Lspsaga lsp_finder<CR>"},
                    {"a", "<cmd> Lspsaga code_action<CR>"}
                }
            },
            {"K", "<cmd> Lspsaga hover_doc<CR>"},
            {"]d", "<cmd> Lspsaga diagnostic_jump_next<CR>"},
            {"[d", "<cmd> Lspsaga diagnostic_jump_prev<CR>"}
        },
        {
            mode = "v",
            {"ga", ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>"}
        }
    }
end

local function configure_capabilities()
    local cmp = require("cmp_nvim_lsp")
    local capabilities = cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits"
        }
    }

    return capabilities
end

local function setup_lsp(lsp, settings)
    nvim_lsp[lsp].setup({on_attach = on_attach, capabilities = configure_capabilities(), settings = settings or {}})
end

local function setup_all_servers(servers)
    for _, lsp in ipairs(servers) do
        setup_lsp(lsp)
    end
end

function M.setup_lsp()
    disable_virtual_text()

    setup_all_servers(
        {
            "bashls",
            "cssls",
            "denols",
            "gopls",
            "html",
            "pylsp",
            "rust_analyzer",
            "tailwindcss",
            "texlab",
            "tsserver",
            "vuels"
        }
    )
end

-- TODO:
-- Inspiration for autoformatters and stuff like that:
-- https://github.com/ngtinsmith/dotfiles/blob/b78bf3115d746d037c814ce6767b4c6ba38021c5/.vimrc#L558

return M
