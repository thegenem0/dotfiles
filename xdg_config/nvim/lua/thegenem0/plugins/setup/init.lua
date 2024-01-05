local ui = require('thegenem0.plugins.setup.ui')
local lsp = require('thegenem0.plugins.setup.lsp')

function setupPlugins()
    ui.setupLualine()
    ui.setupTelescope()
    ui.setupMisc()

    lsp.setupLsp()
    lsp.setupTreesitter()
    lsp.setupCmp()
end

return {
    setup = setupPlugins
}
