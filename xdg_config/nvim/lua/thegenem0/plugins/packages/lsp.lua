local M = {
{
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'folke/neodev.nvim',
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } }
      },

    },
  },
{
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects'
    },
    build = ':TSUpdate',
  },
  {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  },
  { 'rmagatti/goto-preview',         opts = {} },
    { "mbbill/undotree" },
  { "christoomey/vim-tmux-navigator" },
  { "github/copilot.vim" },
  { "akinsho/bufferline.nvim",       version = "*", dependencies = "nvim-tree/nvim-web-devicons", opts = {} },
  {
    "olexsmir/gopher.nvim",
    opts = {
      ft = { "go" },
      goimport = 'gopls',
      gofmt = 'gopls',
      max_line_len = 120,
      impl = "impl",
      iferr = "iferr",
    }
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      direction = "float",
      autochdir = true,
      float_opts = {
        border = "single",
      },

    }
  },
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  { "windwp/nvim-ts-autotag" },
  {
    "braxtons12/blame_line.nvim",
    config = function()
      require("blame_line").setup({
        show_in_visual = false,
        show_in_insert = false,
        delay = 1000,
      })
    end
  },
}

return M