---@diagnostic disable: undefined-global
-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- add list of plugins to install
return packer.startup(function(use)
	-- packer can manage itself
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

	-- nvim-reload
	use("famiu/nvim-reload")

	-- DAP
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")

	-- tokyonight colorscheme for transparent terminal
	use("folke/tokyonight.nvim")
	use("chriskempson/base16-vim")

	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

	use("numToStr/Comment.nvim")

	-- github co-pilot
	use("github/copilot.vim")

	-- nvim-transparent
	use("xiyaowong/nvim-transparent")

	-- file explorer
	use({ "nvim-tree/nvim-tree.lua", tag = "nightly" })

	-- vs-code like icons
	use("kyazdani42/nvim-web-devicons")

	-- bufferline
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

	-- lualine status and winbar
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- navic
	use("SmiteshP/nvim-navic")

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.0" }) -- fuzzy finder

	-- nvim-terminal
	use({ "akinsho/toggleterm.nvim", tag = "*" })

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
	})

	-- lsp status
	use("j-hui/fidget.nvim")

	-- indent lines
	use("lukas-reineke/indent-blankline.nvim")

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls
	use("MunifTanjim/prettier.nvim")

	-- rust tools
	use("simrat39/rust-tools.nvim")

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- dashboard config
	use({ "glepnir/dashboard-nvim" })

	-- showing keybindings
	use("folke/which-key.nvim")

	-- packer sync setup
	if packer_bootstrap then
		require("packer").sync()
	end
end)
