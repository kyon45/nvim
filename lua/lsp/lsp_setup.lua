-- https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/lsp/mason.lua

-- # Mason
local servers = {
  -- Scripts
  'lua_ls', -- Lua
  'bashls',
  -- Web Dev
  'html',
  'cssls',
  -- 'tsserver', -- replaced by `typescript-tools.nvim`
  'jsonls',
  -- Other
  'rust_analyzer', -- Cargo conventions: https://doc.rust-lang.org/cargo/guide/project-layout.html
}

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = servers,
})

-- setup nvim-lspconfig
require('mason-lspconfig').setup_handlers({
  function(server)
    if server == 'rust_analyzer' or server == 'tsserver' then
      return
    end

    local opts = {
      on_attach = require('lsp.lsp_handlers').on_attach,
      capabilities = require('lsp.lsp_handlers').capabilities,
    }

    local require_ok, conf_opts = pcall(require, 'lsp.settings.' .. server)
    if require_ok then
      opts = vim.tbl_deep_extend('force', conf_opts, opts)
    end

    require('lspconfig')[server].setup(opts)
  end,
})

require('lsp.lsp_handlers').setup()

-- setup typescript-tools
local ts_tools = require('typescript-tools')
local ts_tools_api = require('typescript-tools.api')
ts_tools.setup({
  on_attach = require('lsp.lsp_handlers').on_attach,
  -- `handlers` can be used to override certain LSP methods.
  handlers = {
    ['textDocument/publishDiagnostics'] = ts_tools_api.filter_diagnostics({ 6133 }),
  },
  settings = {
    ...,
  },
})

-- setup rust-tools
local rt = require('rust-tools')
rt.setup({
  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    capabilities = require('lsp.lsp_handlers').capabilities,
    on_attach = require('lsp.lsp_handlers').on_attach,
    -- on_attach = function(_, bufnr)
    --   -- Hover actions
    --   vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
    --   -- Code action groups
    --   vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    -- end,

    -- standalone file support
    -- setting it to false may improve startup time
    -- standalone = true,
  },
})
