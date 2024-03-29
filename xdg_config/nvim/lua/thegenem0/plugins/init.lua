local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
            lazypath })
end
vim.opt.rtp:prepend(lazypath)


local plugins = require("thegenem0.utils").merge_plugins(
    require("thegenem0.plugins.packages.ui"),
    require("thegenem0.plugins.packages.lsp"),
    require("thegenem0.plugins.packages.extensions"),
    require("thegenem0.plugins.packages.autoformat"),
    require("thegenem0.plugins.packages.debug")
)

require("lazy").setup(plugins)
require("thegenem0.plugins.bootstrap").bootstrap()
