local ok, dap = pcall(require, "dap")
if not ok then
	return
end

dap.adapters.coreclr = {
	type = "executable",
	command = "/home/gergon02/usr/local/bin/netcoredbg/netcoredbg",
	args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to dll ", vim.fn.getcwd() .. "file")
		end,
	},
}
