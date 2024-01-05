local function augroup(name)
  return vim.api.nvim_create_augroup("default" .. name, { clear = true })
end

local function setup()
	-- Check if we need to reload the file when it changed
	vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	  group = augroup("checktime"),
	  command = "checktime",
	})

	-- resize splits if window got resized
	vim.api.nvim_create_autocmd({ "VimResized" }, {
	  group = augroup("resize_splits"),
	  callback = function()
	    local current_tab = vim.fn.tabpagenr()
	    vim.cmd("tabdo wincmd =")
	    vim.cmd("tabnext " .. current_tab)
	  end,
	})
end

return { setup = setup }
