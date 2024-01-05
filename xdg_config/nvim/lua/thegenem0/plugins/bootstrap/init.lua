local ui = require('thegenem0.plugins.bootstrap.ui')
local lsp = require('thegenem0.plugins.bootstrap.lsp')

local function setupPlugins()
    ui.setupLualine()
    ui.setupTelescope()
    ui.setupMisc()

    lsp.setupLsp()
    lsp.setupTreesitter()
    lsp.setupCmp()
end

return {
    bootstrap = setupPlugins
}
