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
        -- Override colors (see ./lua/vscode/colors.lua)
        color_overrides = {
          vscCursorDarkDark = '#3A3A3A', -- 237
        },
        -- Override highlight groups (see ./lua/vscode/theme.lua)
        group_overrides = {
          -- this supports the same val table as vim.api.nvim_set_hl
          -- use colors from this colorscheme by requiring vscode.colors!
          ColorColumn = { fg = 'NONE', bg = '#454545' },
          DiagnosticUnnecessary = { fg = 'NONE', bg = 'NONE', undercurl = true, sp = c.vscYellow },

          DiffviewDiffAddAsDelete = { fg = 'NONE', bg = c.vscDiffRedLight }, -- bg = '#431313' },
          DiffviewDiffDelete = { fg = c.vscLineNumber },
          DiffAdd = { fg = 'NONE', bg = c.vscDiffGreenDark },
          DiffAddAsDelete = { fg = 'NONE', bg = c.vscDiffRedDark },
          DiffAddText = { fg = 'NONE', bg = c.vscDiffGreenLight },
          DiffDeleteText = { fg = 'NONE', bg = c.vscDiffRedLight },
        },
      })
      require('vscode').load()
    end,
  },
}
