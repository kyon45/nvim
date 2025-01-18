return {
  ---@type LazySpec
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
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end, {
            desc = 'Next Hunk',
          })

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end, {
            desc = 'Prev Hunk',
          })

          -- Actions
          --- hunks
          map('n', '<leader>hp', gitsigns.preview_hunk, {
            desc = 'Preview Hunk',
          })
        end,
      })
    end,
  },
}
