-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use("folke/tokyonight.nvim")

	use({ "nvim-tree/nvim-tree.lua", tag = "nightly" })

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	use("mbbill/undotree")

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ -- Optional
				"williamboman/mason.nvim",
				run = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- source for text in buffer
			{ "hrsh7th/cmp-path" }, -- source for file system paths
			{ "jose-elias-alvarez/typescript.nvim" },
			{ "saadparwaiz1/cmp_luasnip" }, -- for autocompletion
			{ "rafamadriz/friendly-snippets" }, -- useful snippets
		},
	})

	use("github/copilot.vim")

	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use("SmiteshP/nvim-navic")
	use({ "akinsho/toggleterm.nvim", tag = "*" })
	use("j-hui/fidget.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags
	-- dashboard config
	use({ "glepnir/dashboard-nvim" })

	-- showing keybindings
	use("folke/which-key.nvim")
end)
