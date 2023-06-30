return {
  {
    'Mofiqul/vscode.nvim',
    lazy = false, -- make sure we load theme during startup
    priority = 1000,
    config = function()
      vim.o.background = 'dark'
      -- config and load colorscheme here
      -- vim.o.background = 'dark'
      local c = require('vscode.colors').get_colors()
      require('vscode').setup({
        style = 'dark',
        -- Enable transparent background
        transparent = true,
        -- Enable italic comment
        italic_comments = true,
        -- Disable nvim-tree background color
        disable_nvimtree_bg = true,
        -- Ovverride colors (see ./lua/vscode/colors.lua)
        -- color_overrides = {
        -- }
        -- Override highlight groups (see ./lua/vscode/theme.lua)
        group_overrides = {
          -- this supports the same val table as vim.api.nvim_set_hl
          -- use colors from this colorscheme by requiring vscode.colors!
          ColorColumn = { fg='NONE', bg=c.vscLineNumber },
        }
      })
      require('vscode').load()
    end
  }
}

