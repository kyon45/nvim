return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          theme = 'vscode',
        },
        sections = {
          -- https://github.com/nvim-lualine/lualine.nvim#filename-component-options
          lualine_c = {
            {
              'filename',
              path = 1, -- 0: Just the filename
                        -- 1: Relative path
                        -- 2: Absolute path
                        -- 3: Absolute path, with tilde as the home directory
                        -- 4: Filename and parent dir, with tilde as the home directory
            },
          },
        },
      })
    end
  }
}

