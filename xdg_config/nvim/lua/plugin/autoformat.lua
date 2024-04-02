return {
  'neovim/nvim-lspconfig',
  config = function()
    local format_is_enabled = true
    vim.api.nvim_create_user_command('KickstartFormatToggle', function()
      format_is_enabled = not format_is_enabled
      print('Setting autoformatting to: ' .. tostring(format_is_enabled))
    end, {})

    local _augroups = {}
    local get_augroup = function(client)
      if not _augroups[client.id] then
        local group_name = 'kickstart-lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),

      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        if client.name == "tsserver" then
          return
        elseif client.name == "eslint" then
          vim.b.eslint_formatter_attached = true
          client.server_capabilities.documentFormattingProvider = true
        end

        if not client.server_capabilities.documentFormattingProvider then
          return
        end

        vim.api.nvim_create_autocmd('BufWritePre', {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            if not format_is_enabled then
              return
            end
            print('Formatting ' .. vim.api.nvim_buf_get_name(bufnr) .. ' with ' .. client.name)

            vim.lsp.buf.format {
              async = false,
              filter = function(c)
                if vim.b.eslint_formatter_attached then
                  return c.name == "eslint"
                end
                return c.id == client.id
              end,
            }
          end,
        })
      end,
    })
  end,
}
