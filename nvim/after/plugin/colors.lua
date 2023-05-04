function SetColorScheme(color)
	color = color or "tokyonight"
	vim.cmd.colorscheme(color)
end

SetColorScheme()
