---@diagnostic disable: undefined-global
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local rustOptions = {
	extra_args = function(params)
		local Path = require("plenary.path")
		local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

		if cargo_toml:exists() and cargo_toml:is_file() then
			for _, line in ipairs(cargo_toml:readlines()) do
				local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
				if edition then
					return { "--edition=" .. edition }
				end
			end
		end
		-- default edition when we don't find `Cargo.toml` or the `edition` in it.
		return { "--edition=2021" }
	end,
}

null_ls.setup({
	sources = {
		formatting.prettier,
		formatting.stylua,
		formatting.rustfmt.with(rustOptions),
		diagnostics.eslint,
		formatting.terraform_fmt,
		formatting.terrafmt,
	},
	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
