-- https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/lsp/mason.lua

-- # Mason
local servers = {
  -- Scripts
  'lua_ls', -- Lua
  'bashls',
  -- Web Dev
  'html',
  'cssls',
  'ts_ls', -- required by `typescript-tools.nvim`
  'jsonls',
  -- Other
  'rust_analyzer', -- Cargo conventions: https://doc.rust-lang.org/cargo/guide/project-layout.html
}

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = servers,
})
require('mason-tool-installer').setup({
  ensure_installed = {
    -- Linter
    {
      'eslint_d',
      -- see formatter_and_linter.lua for more details
      version = '13.1.2',
    },
    -- Formatter
    'prettier',
    'stylua',
  },
})
