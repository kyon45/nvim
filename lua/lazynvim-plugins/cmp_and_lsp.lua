return {
  -- CMP
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'L3MON4D3/LuaSnip' },
  { 'hrsh7th/nvim-cmp' },
  -- LSP
  { 'neovim/nvim-lspconfig' },
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate', -- update registry contents
  },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'RRethy/vim-illuminate' },
  -- Language Tools
  { 'simrat39/rust-tools.nvim' },
}

