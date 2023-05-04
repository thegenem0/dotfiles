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

return packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use("folke/tokyonight.nvim")

    -- use { "catppuccin/nvim", as = "catppuccin" }

	use({ "nvim-tree/nvim-tree.lua", tag = "nightly" })

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	use("mbbill/undotree")

    use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

	use("numToStr/Comment.nvim")

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

    use('rmagatti/goto-preview')

    use{'weilbith/nvim-code-action-menu', cmd= 'CodeActionMenu'}

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

if packer_bootstrap then
		require("packer").sync()
	end
end)
