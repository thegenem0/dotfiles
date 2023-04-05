local status, lsp = pcall(require, "lsp-zero")
if not status then
	return
end

local keymap = vim.keymap

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"lua_ls",
	"rust_analyzer",
	"tailwindcss",
	"cssls",
	"jsonls",
	"html",
	"yamlls",
	"terraformls",
})

local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-Space>"] = cmp.mapping.complete(),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts, { desc = "Edit Definition" })
	keymap.set(
		"n",
		"gf",
		":lua require('goto-preview').goto_preview_definition()<CR>",
		opts,
		{ desc = "Flotaing Definition" }
	)
	keymap.set(
		"n",
		"gt",
		":lua require('goto-preview').goto_preview_type_definition()<CR>",
		opts,
		{ desc = "Floating Type Definition" }
	)
keymap.set(
		"n",
		"q",
		":lua require('goto-preview').close_all_win()<CR>",
		opts,
		{ desc = "Close floating windows" }
	)
	-- keymap.set("n", "<leader>ca", function()
	-- 	vim.lsp.buf.code_action()
	-- end, opts, { desc = "Code Actions" })
    
    keymap.set("n", "<leader>ca", ":CodeActionMenu<CR>", opts, { desc = "Smart Rename" })

	keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts, { desc = "Smart Rename" })
	keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float()
	end, opts, { desc = "Cursor Diagnostics" })
	keymap.set("n", "<C-k>", function()
		vim.diagnostic.goto_prev()
	end, opts, { desc = "Jump Prev Diagnostic" })
	keymap.set("n", "<C-j>", function()
		vim.diagnostic.goto_next()
	end, opts, { desc = "Jump Next Diagnostic" })
	keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts, { desc = "Cursor Docs" })
	keymap.set("i", "<C-Space>", function()
		vim.lsp.buf.signature_help()
	end, opts, { desc = "Signature Help" })
end)

lsp.setup()
