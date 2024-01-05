local function map(mode, map_to, map_from, opts)
	local default_opts = { noremap = true, silent = true }
	if opts then
		default_opts = vim.tbl_extend('force', default_opts, opts)
	end
	vim.keymap.set(mode, map_to, map_from, default_opts)
end

-- TODO: refactor to standard syntax
local function setup_nonstandard()
	vim.cmd([[
	command! W write
	command! Q quit
	command! Wq write | quit
	command! WQ write | quit
	]])

	-- remap terminal mode escape keys
	vim.cmd([[
	tnoremap <esc> <C-\><C-N>
	]])
end

local function setup()
	---------------------
	-- General Keymaps
	---------------------

	-- disable arrow navigation in normal mode cuz I always fatfinger them
	map("n", "<Up>", "<Nop>")
	map("n", "<Down>", "<Nop>")
	map("n", "<Left>", "<Nop>")
	map("n", "<Right>", "<Nop>")

	map("i", "<C-j>", "<Down>", { desc = "Insert Mode Down" })
	map("i", "<C-k>", "<Up>", { desc = "Insert Mode Up" })
	map("i", "<C-h>", "<Left>", { desc = "Insert Mode Left" })
	map("i", "<C-l>", "<Right>", { desc = "Insert Mode Right" })


	map("n", "q", "<Nop>")

	map("n", "<leader>ch", ":nohl<CR>", { desc = "Clear Search Highlights" })

	map("n", "x", '"_x', { desc = "Delete Char without Copy" })

	map("n", "<leader>sv", "<C-w>v", { desc = "Split Vertical" })
	map("n", "<leader>sh", "<C-w>s", { desc = "Split Horizontal" })
	map("n", "<leader>se", "<C-w>=", { desc = "Make Equal" })
	map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close Current" })

	map("n", "<leader>p", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
	map("n", "<leader>n", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })

	----------------------
	-- Plugin Keybinds
	----------------------

	map('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
	map('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
	map('n', '<leader>fs', require('telescope.builtin').live_grep, { desc = '[F]ind [S]trings' })
	map('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
	map('n', '<leader>nb', require('nvim-navbuddy').open, { desc = '[N]av[B]uddy' })

	map("n", "<leader>ca", "<cmd>CodeActionMenu<cr>", { desc = "Smart Rename" })
	map("n", "gf", "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", { desc = "Flotaing Definition" })
	map("n", "gt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<cr>",
	    { desc = "Floating Type Definition" })

	map("n", "q", "<cmd>lua require('goto-preview').close_all_win()<cr>", { desc = "Close floating windows" })

	map("n", "<C-k>", function()
	    vim.diagnostic.goto_prev()
	end, { desc = "Jump Prev Diagnostic" })

	map("n", "<C-j>", function()
	    vim.diagnostic.goto_next()
	end, { desc = "Jump Next Diagnostic" })

	map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle Explorer" })

	map("n", "<leader>u", vim.cmd.UndotreeToggle)

	map("n", "<leader>tt", "<cmd>ToggleTerm<cr>")

	map('n', "<leader>b", "<cmd>DapToggleBreakpoint<cr>", { desc = "Toggle Breakpoint" })
	map('n', "<leader>rs", "<cmd>LspRestart<cr>", { desc = "Continue" })

    setup_nonstandard()
end

return { setup = setup }
