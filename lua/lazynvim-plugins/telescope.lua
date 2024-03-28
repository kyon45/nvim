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
      vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opt)
      vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opt)
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opt)
      vim.keymap.set('n', '<leader>fh', '<cmd>Telescope buffers<CR>', opt)
      vim.keymap.set('n', '<leader>fk', '<cmd>Telescope keymaps<CR>', opt)

      local builtin = require('telescope.builtin')
      local live_grep_raw = function ()
        builtin.live_grep({
          additional_args = {
            -- https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#common-options
            '--fixed-strings',
          },
          prompt_title = 'Live Grep (Raw)',
        })
      end
      vim.keymap.set('n', '<leader>fgr', live_grep_raw, opt)
    end,
  },
}
