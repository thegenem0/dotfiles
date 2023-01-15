local status, transparent = pcall(require, "transparent")
if not status then
	return
end

transparent.setup({
	enable = true,
	extra_groups = {},
	exclude = {
		"lualine",
	},
})
