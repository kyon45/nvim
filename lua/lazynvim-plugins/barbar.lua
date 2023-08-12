return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      --> to align with NvimTree, see: https://reurl.cc/y7LzMD
      --> the default separator used in barbar.nvim is '▎'(U+258E), called "Left One Quarter Block"
      vim.opt.fillchars:append('vert:▏') -- U+258F, called "Left One Eighth Block"

      vim.g.barbar_auto_setup = false
    end,
    opts = { -- lazy.nvim will automatically call `setup` for you
      icons = {
        button = '×', -- the close icon
        -- separator = {left = '▎', right = ''},
        gitsigns = {
          added = {enabled = true, icon = '+'},
          changed = {enabled = true, icon = '~'},
          deleted = {enabled = true, icon = '-'},
        },
      },
      -- Set the filetype which barbar will offset itself for
      sidebar_filetypes = {
        -- Use the default values: {event = 'BufWinLeave', text = nil}
        NvimTree = true,
      },
      -- Set the name of unnamed buffers
      no_name_title = '[NO NAME]',
    },
    version = '^1.0.0',
  },
}

