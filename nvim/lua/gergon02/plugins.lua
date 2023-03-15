local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	"wbthomason/packer.nvim",
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	"famiu/nvim-reload", -- nvim-reload
	-- DAP
	"mfussenegger/nvim-dap",
	-- tokyonight colorscheme for transparent terminal
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
	"numToStr/Comment.nvim",
	-- github co-pilot
	"github/copilot.vim",
	-- nvim-transparent
	"xiyaowong/nvim-transparent",
	-- file explorer
	{ "nvim-tree/nvim-tree.lua", version = "nightly" },
	-- bufferline
	{ "akinsho/bufferline.nvim", version = "v3.*", dependencies = "nvim-tree/nvim-web-devicons" },
	-- lualine status and winbar
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
	},
	-- navic
	"SmiteshP/nvim-navic",
	-- fuzzy finding w/ telescope
	{ "nvim-telescope/telescope.nvim" }, -- fuzzy finder
	-- nvim-terminal
	{ "akinsho/toggleterm.nvim" },
	-- autocompletion
	"hrsh7th/nvim-cmp", -- completion plugin
	"hrsh7th/cmp-buffer", -- source for text in buffer
	"hrsh7th/cmp-path", -- source for file system paths

	-- snippets
	"L3MON4D3/LuaSnip", -- snippet engine
	"saadparwaiz1/cmp_luasnip", -- for autocompletion
	"rafamadriz/friendly-snippets", -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	"williamboman/mason.nvim", -- in charge of managing lsp servers, linters & formatters
	"williamboman/mason-lspconfig.nvim", -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	"neovim/nvim-lspconfig", -- easily configure language servers
	"hrsh7th/cmp-nvim-lsp", -- for autocompletion
	"jose-elias-alvarez/typescript.nvim", -- additional functionality for typescript server (e.g. rename file & update imports)
	"onsails/lspkind.nvim", -- vs-code like icons for autocompletion

	{
		"glepnir/lspsaga.nvim",
		branch = "main",
	},

	-- lsp status
	"j-hui/fidget.nvim",

	-- indent lines
	"lukas-reineke/indent-blankline.nvim",

	-- formatting & linting
	"jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
	"jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls
	"MunifTanjim/prettier.nvim",

	-- rust tools
	"simrat39/rust-tools.nvim",

	-- treesitter configuration
	{
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	},

	-- auto closing
	"windwp/nvim-autopairs", -- autoclose parens, brackets, quotes, etc...
	{ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }, -- autoclose tags

	-- git integration
	"lewis6991/gitsigns.nvim", -- show line modifications on left hand side

	-- dashboard config
	"glepnir/dashboard-nvim",

	-- showing keybindings
	"folke/which-key.nvim",
}

local opts = {
	defaults = {
		lazy = true,
	},
}

require("lazy").setup(plugins, opts)
