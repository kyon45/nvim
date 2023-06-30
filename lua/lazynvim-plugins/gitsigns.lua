return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        signcolumn = true,
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 200,
          ignore_whitespace = false,
        },
      })
    end
  }
}

