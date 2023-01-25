-- import lspsaga safely
local lspsaga_status, lspsaga = pcall(require, "lspsaga")
if not lspsaga_status then
	return
end

local new_colors = {
	blue = "#65d1ff",
	green = "#3effdc",
	violet = "#ff61ef",
	yellow = "#ffda7b",
	black = "#000000",
	red = "#ec5f67",
	orange = "#FF8800",
	gray = "#282C41",
}

lspsaga.setup({ -- defaults ...
	ui = {
		-- currently only round theme
		theme = "round",
		-- border type can be single,double,rounded,solid,shadow.
		border = "solid",
		winblend = 0,
		expand = "",
		collapse = "",
		preview = " ",
		code_action = "💡",
		diagnostic = "🐞",
		incoming = " ",
		outgoing = " ",
		colors = {
			--float window normal background color
			normal_bg = new_colors.gray,
			--title background color
			title_bg = "#afd700",
			red = new_colors.red,
			magenta = "#b33076",
			orange = new_colors.orange,
			yellow = new_colors.yellow,
			green = new_colors.green,
			cyan = "#36d0e0",
			blue = new_colors.blue,
			purple = new_colors.violet,
			white = "#d1d4cf",
			black = "#1c1c19",
		},
		kind = {},
	},
	definition = {
		edit = "<CR>",
		vsplit = "<C-c>v",
		split = "<C-c>i",
		tabe = "<C-c>t",
		quit = "q",
		close = "<Esc>",
	},
})
