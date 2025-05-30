-- setup nvim-lspconfig
require('mason-lspconfig').setup_handlers({
  function(server)
    if server == 'rust_analyzer' or server == 'ts_ls' then
      return
    end

    local opts = {
      on_attach = require('lang.lsp_handlers').on_attach,
      capabilities = require('lang.lsp_handlers').capabilities,
    }

    local require_ok, conf_opts = pcall(require, 'lang.settings.' .. server)
    if require_ok then
      opts = vim.tbl_deep_extend('force', conf_opts, opts)
    end

    require('lspconfig')[server].setup(opts)
  end,
})

require('lang.lsp_handlers').setup()

-- TODO: move to lang.settings
-- setup typescript-tools
local ts_tools = require('typescript-tools')
local ts_tools_api = require('typescript-tools.api')
ts_tools.setup({
  on_attach = require('lang.lsp_handlers').on_attach,
  capabilities = require('lang.lsp_handlers').capabilities,
  -- `handlers` can be used to override certain LSP methods.
  handlers = {
    ['textDocument/publishDiagnostics'] = ts_tools_api.filter_diagnostics({ 6133 }),
  },
  settings = {
    ...,
  },
})

-- setup rustaceanvim
---@type rustaceanvim.Opts
vim.g.rustaceanvim = {
  tools = {
    float_win_config = {
      border = 'rounded',
    },
  },
  server = {
    on_attach = function(client, bufnr)
      require('lang.lsp_handlers').on_attach(client, bufnr, {
        maps = {
          ['n'] = {
            ['K'] = {
              -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
              function()
                vim.cmd.RustLsp({ 'hover', 'actions' })
              end,
              desc = '[Rust] LSP Hover',
            },
            ['<leader>ca'] = {
              -- supports rust-analyzer's grouping
              function()
                vim.cmd.RustLsp('codeAction')
              end,
              desc = '[Rust] LSP Code Action',
            },
          },
        },
      })
    end,
    capabilities = require('lang.lsp_handlers').capabilities,
  },
}
