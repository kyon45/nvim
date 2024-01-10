return {
  {
    'sindrets/diffview.nvim',
    config = function()
      require('diffview').setup({
        use_icons = true, -- Requires nvim-web-devicons
        hooks = {
          -- @README https://github.com/sindrets/diffview.nvim/pull/258#issuecomment-1332166876
          -- https://github.com/sindrets/dotfiles/blob/6a18ea39/.config/nvim/lua/user/plugins/diffview.lua#L76
          diff_buf_win_enter = function(bufnr, winid, ctx)
            -- Highlight 'DiffChange' as 'DiffDelete' on the left (a),
            -- and 'DiffAdd' on the right(b).
            if ctx.layout_name:match('^diff2') then
              if ctx.symbol == 'a' then -- left
                vim.opt_local.winhl = table.concat({
                  'DiffAdd:DiffviewDiffAddAsDelete',
                  'DiffDelete:DiffviewDiffDelete',
                  'DiffChange:DiffAddAsDelete',
                  'DiffText:DiffDeleteText',
                }, ',')
              elseif ctx.symbol == 'b' then -- right
                vim.opt_local.winhl = table.concat({
                  'DiffDelete:DiffviewDiffDelete',
                  'DiffChange:DiffAdd',
                  'DiffText:DiffAddText',
                }, ',')
              end
            end
          end,
        },
      })

      local opts = {
        noremap = true,
        silent = true,
      }

      vim.keymap.set('n', '<leader>do', ':NvimTreeClose <BAR> :DiffviewOpen<CR>', opts)
      vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>', opts)

      -- https://github.com/sindrets/diffview.nvim/issues/35
      local set = vim.opt
      set.fillchars = set.fillchars + 'diff:╱'
    end,
  },
}
