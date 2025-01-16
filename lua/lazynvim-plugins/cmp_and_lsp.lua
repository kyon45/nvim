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
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
  },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'RRethy/vim-illuminate' },
  -- Language Tools
  {
    'pmizio/typescript-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
  },
  { 'simrat39/rust-tools.nvim' },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    dependencies = {
      -- https://www.reddit.com/r/neovim/comments/1g0tn6t/lazydev_and_wezterm_types
      { 'gonstoll/wezterm-types', lazy = true },
    },
    cmd = 'LazyDev',
    opts = {
      library = {
        'lazy.nvim',
        -- 3rd
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = 'yazi.nvim', words = { 'YaziConfig' } },
        { path = 'wezterm-types', mods = { 'wezterm' } },
      },
    },
  },
}
