local api = vim.api
local keymap = vim.keymap
local status, dashboard = pcall(require, "dashboard")
if not status then
	return
end

dashboard.setup({
	theme = "doom",
	config = {
		header = {

			"                                                                               ",
			"                                                                               ",
			"                                                                               ",
			"                                                                               ",
			"       ██╗░░░██╗░██████╗██╗███╗░░██╗░██████╗░  ██╗░░░██╗██╗███╗░░░███╗         ",
			"       ██║░░░██║██╔════╝██║████╗░██║██╔════╝░  ██║░░░██║██║████╗░████║         ",
			"       ██║░░░██║╚█████╗░██║██╔██╗██║██║░░██╗░  ╚██╗░██╔╝██║██╔████╔██║         ",
			"       ██║░░░██║░╚═══██╗██║██║╚████║██║░░╚██╗  ░╚████╔╝░██║██║╚██╔╝██║         ",
			"       ╚██████╔╝██████╔╝██║██║░╚███║╚██████╔╝  ░░╚██╔╝░░██║██║░╚═╝░██║         ",
			"       ░╚═════╝░╚═════╝░╚═╝╚═╝░░╚══╝░╚═════╝░  ░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝         ",
			"                                                                               ",
			"         ██╗░██████╗  ░█████╗░██████╗░██╗███╗░░██╗░██████╗░███████╗            ",
			"         ██║██╔════╝  ██╔══██╗██╔══██╗██║████╗░██║██╔════╝░██╔════╝            ",
			"         ██║╚█████╗░  ██║░░╚═╝██████╔╝██║██╔██╗██║██║░░██╗░█████╗░░            ",
			"         ██║░╚═══██╗  ██║░░██╗██╔══██╗██║██║╚████║██║░░╚██╗██╔══╝░░            ",
			"         ██║██████╔╝  ╚█████╔╝██║░░██║██║██║░╚███║╚██████╔╝███████╗            ",
			"         ╚═╝╚═════╝░  ░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░╚══╝░╚═════╝░╚══════╝            ",
			"                                                                               ",
			"       ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬ ▬       ",
			"                                                                               ",
			"                                                                               ",
		},
		center = {
			{
				icon = "  ",
				desc = "Find  File                              ",
				action = "Telescope find_files",
				shortcut = "<Leader> f f",
			},
			{
				icon = "  ",
				desc = "Recently opened files                   ",
				action = "Telescope oldfiles",
				shortcut = "<Leader> f r",
			},
			{
				icon = "  ",
				desc = "Project grep                            ",
				action = "Telescope live_grep",
				shortcut = "<Leader> f s",
			},
			{
				icon = "  ",
				desc = "Open Nvim config                        ",
				action = "tabnew $MYVIMRC | tcd %:p:h",
				shortcut = "<Leader> e v",
			},
			{
				icon = "  ",
				desc = "New file                                ",
				action = "enew",
				shortcut = "e           ",
			},
			{
				icon = "  ",
				desc = "Quit Nvim                               ",
				-- desc = "Quit Nvim                               ",
				action = "qa",
				shortcut = "q           ",
			},
		},
		footer = {},
	},
})

api.nvim_create_autocmd("FileType", {
	pattern = "dashboard",
	group = api.nvim_create_augroup("dashboard_enter", { clear = true }),
	callback = function()
		keymap.set("n", "q", ":qa<CR>", { buffer = true, silent = true })
		keymap.set("n", "e", ":enew<CR>", { buffer = true, silent = true })
	end,
})
