-- https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/lsp/mason.lua

-- # Mason
local servers = {
  -- Scripts
  'lua_ls', -- Lua
  'bashls',
  -- Web Dev
  'html',
  'cssls',
  'tsserver', -- TypeScript
  'jsonls',
  -- 'eslint',
}

require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = servers,
}

-- setup nvim-lspconfig
-- local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
-- if not lsconfig_status_ok then return end
-- 
-- local opts = {}
-- 
-- for _, server in pairs(servers) do
--   opts = {
--     on_attach = require('cmp_and_lsp.lsp_handlers').on_attach,
--     capabilities = require('cmp_and_lsp.lsp_handlers').capabilities,
--   }
-- 
--   -- server = vim.split(server, '@')[1]
--   lspconfig[server].setup(opts)
-- end
require('mason-lspconfig').setup_handlers {
  function (server)
    opts = {
      on_attach = require('cmp_and_lsp.lsp_handlers').on_attach,
      capabilities = require('cmp_and_lsp.lsp_handlers').capabilities,
    }
    require('lspconfig')[server].setup(opts)
  end
}

require('cmp_and_lsp.lsp_handlers').setup()

