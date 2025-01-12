return {
  ---@type LazySpec
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        '<leader>y',
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at the current file',
      },
      {
        -- Open in the current working directory
        '<leader>cw',
        '<cmd>Yazi cwd<cr>',
        desc = "Open the file manager in nvim's working directory",
      },
      -- {
      --   -- NOTE: this requires a version of yazi that includes
      --   -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
      --   '<c-up>',
      --   '<cmd>Yazi toggle<cr>',
      --   desc = 'Resume the last yazi session',
      -- },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    },
    init = function()
      local opts = {
        noremap = true, -- non-recursive
        silent = true,
      }
      -- buffer
      vim.keymap.set('n', '<leader>bc', '<cmd>BufferClose<CR>', opts)
      vim.keymap.set('n', '<leader>bt', '<cmd>BufferCloseAllButCurrent<CR>', opts)
      vim.keymap.set('n', '<leader>bh', '<cmd>BufferPrevious<CR>', opts)
      vim.keymap.set('n', '<leader>bl', '<cmd>BufferNext<CR>', opts)
    end,
  },
}
