local M = {
    {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
    },
    { 'rmagatti/goto-preview', opts = {} },
    { "mbbill/undotree" },
    { "github/copilot.vim" },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            direction = "float",
            autochdir = true,
            float_opts = {
                border = "single",
            },

        }
    },
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },
    { "windwp/nvim-ts-autotag" },
    {
        "braxtons12/blame_line.nvim",
        config = function()
            require("blame_line").setup({
                show_in_visual = false,
                show_in_insert = false,
                delay = 1000,
            })
        end
    },
}

return M
