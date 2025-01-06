return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup()

      local opt = {
        noremap = true,
        silent = true,
      }
      vim.keymap.set('n', '<leader>bb', '<cmd>NvimTreeToggle<CR>', opt)
    end,
  },
}
