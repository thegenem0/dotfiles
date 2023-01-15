local setup, lualine = pcall(require, "lualine")
if not setup then
	return
end

local navic_setup, navic = pcall(require, "nvim-navic")
if not navic_setup then
	return
end

local lualine_nightfly = require("lualine.themes.nightfly")

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

lualine_nightfly.normal.a.bg = new_colors.blue
lualine_nightfly.insert.a.bg = new_colors.green
lualine_nightfly.visual.a.bg = new_colors.violet
lualine_nightfly.command = {
	a = {
		gui = "bold",
		bg = new_colors.yellow,
		fg = new_colors.black,
	},
}

local config = {
	options = {
		icons_enabled = true,
		theme = lualine_nightfly,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {
				"help",
				"startify",
				"dashboard",
				"packer",
				"neogitstatus",
				"NvimTree",
				"Trouble",
				"alpha",
				"lir",
				"Outline",
				"spectre_panel",
				"toggleterm",
				"qf",
			},
			winbar = {
				"help",
				"startify",
				"dashboard",
				"packer",
				"neogitstatus",
				"NvimTree",
				"Trouble",
				"alpha",
				"lir",
				"Outline",
				"spectre_panel",
				"toggleterm",
				"qf",
			},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {
		lualine_a = { {
			function()
				return " "
			end,
		} },
		lualine_b = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " " },
				diagnostics_color = {
					color_error = { fg = new_colors.red },
					color_warn = { fg = new_colors.yellow },
					color_info = { fg = new_colors.violet },
				},
			},
			{ navic.get_location, cond = navic.is_available, color = { fg = new_colors.green, gui = "bold" } },
		},
		lualine_c = {},
		lualine_x = {
			{
				"diff",
				-- Is it me or the symbol for modified us really weird
				symbols = { added = " ", modified = "柳 ", removed = " " },
				diff_color = {
					added = { fg = new_colors.green },
					modified = { fg = new_colors.orange },
					removed = { fg = new_colors.red },
				},
			},
		},
		lualine_y = {
			{
				-- Lsp server name .
				function()
					local msg = "No Active Lsp"
					local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
					local clients = vim.lsp.get_active_clients()
					if next(clients) == nil then
						return msg
					end
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return client.name
						end
					end
					return msg
				end,
				icon = " LSP:",
				color = { fg = "#ffffff", gui = "bold" },
			},
		},
		lualine_z = {
			{
				function()
					return " "
				end,
			},
		},
	},
	inactive_winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = {
		"nvim-tree",
		"toggleterm",
	},
}

lualine.setup(config)
