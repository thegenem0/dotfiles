local M = {}

M.servers = {
    gopls = {},
    rust_analyzer = {},
    tsserver = {},
    html = {
        filetypes = { 'html', 'twig', 'hbs' }
    },
    cssls = {
        filetypes = { 'css', 'scss', 'less' }
    },
    jsonls = {
        filetypes = { 'json', 'jsonc' }
    },
    tailwindcss = {},
    kotlin_language_server = {},
    yamlls = {
        schemaStore = {
            enable = true
        }
    },

    lua_ls = {
        Lua = {
            workspace = {
                checkThirdParty = false
            },
            telemetry = {
                enable = false
            }
        }
    }
}

function M.setupTreesitter()
    require('nvim-treesitter.configs').setup {
        highlight = {
            enable = true
        },
        ensure_installed = { "bash", "html", "javascript", "json", "lua", "luadoc", "luap", "markdown",
            "markdown_inline", "regex", "tsx", "typescript", "yaml", "go" }
    }
end

function M.setupLsp()
    local on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end

            if client.server_capabilities.documentSymbolProvider then
                navic.attach(client, bufnr)
            end

            vim.keymap.set('n', keys, func, {
                buffer = bufnr,
                desc = desc
            })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
        end, {
            desc = 'Format current buffer with LSP'
        })
    end
end

function M.setupCmp()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(M.servers)
    }

    mason_lspconfig.setup_handlers { function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            flags = lsp_flags,
            on_attach = on_attach,
            settings = M.servers[server_name],
            filetypes = (M.servers[server_name] or {}).filetypes
        }
    end }

    -- [[ Configure nvim-cmp ]]
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end
        },
        mapping = cmp.mapping.preset.insert {
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {},
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true
            }
        },
        sources = { {
            name = 'nvim_lsp'
        }, {
            name = 'luasnip'
        } }
    }
end

return M
