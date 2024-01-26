-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#lazynvim
-- https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/treesitter.lua
local ensure_installed = {
  'lua',
  -- Front End
  'javascript',
  'typescript',
  'tsx',
  'json',
  'jsonc', -- JSON with comments
  'html',
  -- Other
  'vim',
  'python',
  'rust',
  'bash',
  'markdown',
  'markdown_inline', -- required by `lspsaga`
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    -- TODO: JoosepAlviste/nvim-ts-context-commentstring
    build = ':TSUpdate',
    config = function()
      local configs = require('nvim-treesitter.configs')
      configs.setup({
        ensure_installed = ensure_installed,
        ignore_installed = { '' },
        sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        -- autopairs = {
        --   enable = true,
        -- },
        indent = {
          enable = true,
        },
      })
    end,
  },
}
