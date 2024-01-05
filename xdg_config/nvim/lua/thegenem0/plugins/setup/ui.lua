local M = {}

function M.setupLualine()
    local navic = require('nvim-navic')
    require('lualine').setup({
        options = {
            icons_enabled = false,
            theme = 'onedark',
            component_separators = '|',
            section_separators = ''
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch'},
            lualine_c = {{
                'filename',
                path = 1
            }},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
        winbar = {
            lualine_a = {{function()
                local version_info = vim.version()
                return "v." .. version_info.major .. '.' .. version_info.minor
            end}},
            lualine_b = {{function()
                if navic.is_available() then
                    return navic.get_location()
                else
                    return "[No buffers]"
                end
            end}}
        }
    })
end

function M.setupTelescope()
    require('telescope').setup {
        defaults = {
            mappings = {
                i = {
                    ['<C-j>'] = require('telescope.actions').move_selection_next,
                    ['<C-k>'] = require('telescope.actions').move_selection_previous,
                    ['<C-u>'] = false,
                    ['<C-d>'] = false
                }
            }
        }
    }

    pcall(require('telescope').load_extension, 'fzf')
end

function M.setupMisc()
    require('neodev').setup()
end

return M
