return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
      require('telescope').setup({})

      local opt = {
        noremap = true,
        silent = true,
      }
      -- local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opt)
      vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opt)
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opt)
      vim.keymap.set('n', '<leader>fh', '<cmd>Telescope buffers<CR>', opt)
      vim.keymap.set('n', '<leader>fk', '<cmd>Telescope keymaps<CR>', opt)
    end,
  },
}
