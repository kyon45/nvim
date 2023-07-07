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
require('mason-lspconfig').setup_handlers {
  function (server)
    opts = {
      on_attach = require('lsp.lsp_handlers').on_attach,
      capabilities = require('lsp.lsp_handlers').capabilities,
    }
    require('lspconfig')[server].setup(opts)
  end
}

require('lsp.lsp_handlers').setup()

