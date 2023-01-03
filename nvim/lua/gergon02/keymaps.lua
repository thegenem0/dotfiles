-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use C-c to exit insert mode
keymap.set("i", "<C-c>", "<ESC>", { desc = "Exit Insert Mode" })

-- clear search highlights
keymap.set("n", "<leader>ch", ":nohl<CR>", { desc = "Clear Search Highlights" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x', { desc = "Delete Char without Copy" })

-- increment/decrement numbers (don't really have a need for these right now)
-- keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment Number" }) -- increment
-- keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement Number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split Vertical" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split Horizontal" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make Equal" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close Current" }) -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "New Tab" }) -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close Tab" }) -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Next Tab" }) --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Prev Tab" }) --  go to previous tab

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

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle Explorer" }) -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" }) -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" }) -- show recently used files
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" }) -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find Current String" }) -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List Buffers" }) -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" }) -- list available help tags

-- telescope git commands (using lazygit in floating term on arch, maybe useful for windows/mac?)
-- keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "List Commits" }) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
-- -- keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", { desc = "List File Commits" }) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
-- keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "List Branches" }) -- list git branches (use <cr> to checkout) ["gb" for git branch]
-- keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" }) -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server
keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" }) -- mapping to restart lsp if necessary

-- lspsaga keybinds (needs to use old style vim remaps, new style bugs out when exiting terminal mode)
vim.cmd([[
  nnoremap <silent> <leader>tt :Lspsaga open_floaterm<CR>
  nnoremap <silent> <leader>tg :Lspsaga open_floaterm lazygit<CR>
  tnoremap <silent> <leader>tt <C-\><C-n>:Lspsaga close_floaterm<CR>
  ]])
