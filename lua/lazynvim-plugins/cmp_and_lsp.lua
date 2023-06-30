return {
  -- CMP
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/nvim-cmp' },
  -- LSP
  { 'neovim/nvim-lspconfig' },
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate', -- update registry contents
  },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'RRethy/vim-illuminate' },
}



