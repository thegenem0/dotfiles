vim.g.mapleader = " "
local keymap = vim.keymap

---------------------
-- General Keymaps
---------------------

keymap.set("i", "<C-j>", "<Down>", { desc = "Insert Mode Down" })
keymap.set("i", "<C-k>", "<Up>", { desc = "Insert Mode Up" })
keymap.set("i", "<C-h>", "<Left>", { desc = "Insert Mode Left" })
keymap.set("i", "<C-l>", "<Right>", { desc = "Insert Mode Right" })

-- remap write and quit to capitals
vim.cmd([[
command! W write
command! Q quit
]])

keymap.set("n", "<leader>ch", ":nohl<CR>", { desc = "Clear Search Highlights" })

keymap.set("n", "x", '"_x', { desc = "Delete Char without Copy" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split Vertical" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split Horizontal" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make Equal" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close Current" })

-- buffer navigation
keymap.set("n", "<leader>p", ":BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
keymap.set("n", "<leader>n", ":BufferLineCycleNext<CR>", { desc = "Next Buffer" })

-- disable arrow navigation in normal mode
keymap.set("n", "<Up>", "<Nop>")
keymap.set("n", "<Down>", "<Nop>")
keymap.set("n", "<Left>", "<Nop>")
keymap.set("n", "<Right>", "<Nop>")

----------------------
-- Plugin Keybinds
----------------------

keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle Explorer" })

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List Buffers" })

-- bufferline stuff
keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Close current Buffer" })

-- restart lsp server
keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })

-- terminal keybinds
keymap.set("n", "<leader>tt", ":ToggleTerm<cr>")
keymap.set("n", "<leader>tg", ":ToggleTerm<cr> gl<cr>")
vim.cmd([[
tnoremap <esc> <C-\><C-N>
]])
