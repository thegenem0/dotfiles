local M = {
    { 'tpope/vim-sleuth' },
    {
        'folke/which-key.nvim',
        opts = {}
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = {
                    text = '+'
                },
                change = {
                    text = '~'
                },
                delete = {
                    text = '_'
                },
                topdelete = {
                    text = '‾'
                },
                changedelete = {
                    text = '~'
                }
            }
        }
    },
    { 'nvim-lualine/lualine.nvim' },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                background_colour = "#000000",
                icons = {
                    ERROR = "",
                    WARN = "",
                    INFO = "",
                    DEBUG = "",
                    TRACE = "✎"
                },
                render = "minimal",
                stages = "fade"
            })
        end
    },
    {
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        -- override the default lsp markdown formatter with Noice
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        -- override the lsp markdown formatter with Noice
                        ["vim.lsp.util.stylize_markdown"] = true,
                        -- override cmp documentation with Noice (needs the other options to work)
                        ["cmp.entry.get_documentation"] = true
                    }
                },
                presets = {
                    lsp_doc_border = true
                }
            })
        end,
        dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" }
    },
    { "christoomey/vim-tmux-navigator" },
    { "akinsho/bufferline.nvim",       version = "*", dependencies = "nvim-tree/nvim-web-devicons", opts = {} },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        module = 'telescope',
        dependencies = { 'nvim-lua/plenary.nvim', {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end
        } }
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup {}
        end
    },
    {
        'xiyaowong/transparent.nvim',
        opts = {}
    },
    {
        'sainnhe/sonokai',
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'sonokai'
        end
    }
}

return M
