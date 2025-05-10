return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim',       opts = {} },
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local fzf = require 'fzf-lua'

        -- Navigation
        map('gd', fzf.lsp_definitions, '[G]oto [D]efinition')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('gr', fzf.lsp_references, '[G]oto [R]eferences')
        map('gI', fzf.lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', fzf.lsp_typedefs, 'Type [D]efinition')

        -- Symbols
        map('<leader>ds', fzf.lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', fzf.lsp_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Diagnostics
        map('<leader>dd', fzf.lsp_document_diagnostics, '[D]ocument [D]iagnostics')
        map('<leader>wd', fzf.lsp_workspace_diagnostics, '[W]orkspace [D]iagnostics')

        -- Actions
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        -- map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('<leader>ca', function()
          require('fzf-lua').lsp_code_actions {
            winopts = {
              height = 0.9,          -- window height
              width = 0.8,           -- window width
              row = 0.5,             -- center vertically
              col = 0.5,             -- center horizontally
              anchor = 'center',     -- anchor point is center
              preview = {
                layout = 'vertical', -- stack preview vertically
                vertical = 'up:50%', -- preview pane at bottom
              },
            },
            fzf_opts = {
              ['--layout'] = 'reverse', -- results on top, prompt at bottom
            },
          }
        end, '[C]ode [A]ction', { 'n', 'x' })
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
    local servers = {
      -- gopls = {},
      -- ruff = {},
      -- basedpyright = {},
      -- html = { filetypes = { 'html', 'twig', 'hbs' } },
      -- cssls = {},
      -- dockerls = {},
      -- sqlls = {},
      -- marksman = {},
      -- ansiblels = {},
      -- docker_compose_language_service = {},
      -- terraformls = {},
      -- jsonls = {},
      -- yamlls = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
            },
            diagnostics = { disable = { 'missing-fields' } },
            format = {
              enable = false,
            },
          },
        },
      },
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
