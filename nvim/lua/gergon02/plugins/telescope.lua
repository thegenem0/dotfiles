local telescope_setup = pcall(require, "telescope")
if not status then
    return
end

local actions_setuo = pcall(require, "telescope.actions")
if not status then
    return
end

telescope.setup({
-- configure custom mappings
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      },
    },
  },
})

telescope.load_extension("fzf")
