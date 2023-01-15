-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	return
end

local navic_status, navic = pcall(require, "nvim-navic")
if not navic_status then
	return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts, { desc = "Show Definition" }) -- show definition, references
	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts, { desc = "Show Declaration" }) -- got to declaration
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts, { desc = "Edit Definition" }) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts, { desc = "Show Implementation" }) -- go to implementation
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts, { desc = "Code Actions" }) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts, { desc = "Smart Rename" }) -- smart rename
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts, { desc = "Line Diagnostics" }) -- show  diagnostics for line
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts, { desc = "Cursor Diagnostics" }) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts, { desc = "Jump Prev Diagnostic" }) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts, { desc = "Jump Next Diagnostic" }) -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts, { desc = "Cursor Docs" }) -- show documentation for what is under cursor
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts, { desc = "Toggle Outline" }) -- see outline on right hand side

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>", { desc = "Rename/Update Imports" }) -- rename file and update imports
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>", { desc = "Organize Imports" }) -- organize imports (not in youtube nvim video)
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>", { desc = "Remove Unused Vars" }) -- remove unused variables (not in youtube nvim video)
	end

	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
	if client.name == "rust_analyzer" then
		client.resolved_capabilities.document_formatting = false
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

local servers = {
	"html",
	"cssls",
	"tailwindcss",
	"eslint",
	"emmet_ls",
	"rust_analyzer",
	"sumneko_lua",
}

for _, server in pairs(servers) do
	local serverOpts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	if server == "rust_analyzer" then
		local ok_rt, rust_tools = pcall(require, "rust-tools")
		if not ok_rt then
			print("Failed to load rust tools, will set up `rust_analyzer` without `rust-tools`.")
		else
			rust_tools.setup({
				tools = {
					autoSetHints = true,
					hover_with_actions = true,
					runnables = {
						use_telescope = true,
					},
				},
				server = serverOpts,
			})
			-- We don't want to call lspconfig.rust_analyzer.setup() when using
			-- rust-tools. See
			-- * https://github.com/simrat39/rust-tools.nvim/issues/183
			-- * https://github.com/simrat39/rust-tools.nvim/issues/177
			goto continue
		end
	end

	if server == "eslint" then
		lspconfig[server].setup(serverOpts, {
			settings = {
				codeActionOnSave = {
					enable = true,
					mode = "all",
				},
			},
			-- Copied from nvim-lspconfig/lua/lspconfig/server_conigurations/eslint.js
			root_dir = lspconfig.util.root_pattern(
				".eslintrc",
				"package.json",
				".eslintrc.js",
				".eslintrc.cjs",
				".eslintrc.yaml",
				".eslintrc.yml",
				".eslintrc.json"
			),
		})
		goto continue
	end

	if server == "emmet_ls" then
		lspconfig[server].setup(
			serverOpts,
			{ filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" } }
		)
		goto continue
	end

	if server == "sumneko_lua" then
		lspconfig[server].setup(serverOpts, {
			{
				settings = { -- custom settings for lua
					Lua = {
						-- make the language server recognize "vim" global
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							-- make language server aware of runtime files
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			},
		})
		goto continue
	end

	lspconfig[server].setup(serverOpts)
	::continue::
end

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure typescript server with plugin
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})
