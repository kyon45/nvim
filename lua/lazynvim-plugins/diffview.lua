return {
  {
    'sindrets/diffview.nvim',
    config = function()
      require('diffview').setup({
        use_icons = true, -- Requires nvim-web-devicons
      })

      local opts = {
        noremap = true,
        silent = true,
      }

      vim.keymap.set('n', '<leader>do', ':NvimTreeClose <BAR> :DiffviewOpen<CR>', opts)
      vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>',  opts)
    end
  }
}

