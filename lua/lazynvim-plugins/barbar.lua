return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false

      -- Keymap
      local opt = {
        noremap = true,
        silent = true,
      }
      vim.keymap.set('n', '<leader>bc', '<cmd>BufferClose<CR>', opt)
      vim.keymap.set('n', '<leader>bt', '<cmd>BufferCloseAllButCurrent<CR>', opt)
    end,
    opts = { -- lazy.nvim will automatically call `setup` for you
      icons = {
        button = '×', -- the close icon
        -- separator = {left = '▎', right = ''},
        gitsigns = {
          added = { enabled = true, icon = '+' },
          changed = { enabled = true, icon = '~' },
          deleted = { enabled = true, icon = '-' },
        },
        -- Enables / disables diagnostic symbols
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true },
          [vim.diagnostic.severity.WARN] = { enabled = true },
          [vim.diagnostic.severity.INFO] = { enabled = false },
          [vim.diagnostic.severity.HINT] = { enabled = false },
        },
      },
      -- Set the filetype which barbar will offset itself for
      sidebar_filetypes = {
        -- Use the default values: {event = 'BufWinLeave', text = nil}
      },
      -- Set the name of unnamed buffers
      no_name_title = '[NO NAME]',
    },
    version = '^1.0.0',
  },
}
