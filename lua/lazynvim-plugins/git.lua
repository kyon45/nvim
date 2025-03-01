return {
  {
    'sindrets/diffview.nvim',
    config = function()
      ---@type DiffviewConfig
      ---@diagnostic disable-next-line:missing-fields
      local diffview_config = {
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
        view = {
          merge_tool = {
            -- Config for conflicted files in diff views during a merge or rebase.
            layout = 'diff1_plain',
          },
        },
      }
      require('diffview').setup(diffview_config)

      -- https://github.com/sindrets/diffview.nvim/issues/35
      local set = vim.opt
      set.fillchars = set.fillchars + 'diff:╱'

      -- user commands
      vim.api.nvim_create_user_command('DiffviewPrompt', function()
        vim.ui.input({ prompt = 'Diffview' }, function(git_rev)
          if not git_rev or type(git_rev) ~= 'string' then
            return
          end

          local args = git_rev
          --- TODO: use "diffview.arg_parser" instead
          if not string.find(git_rev, '%.%.') then
            args = git_rev .. '^!'
          end

          vim.cmd('DiffviewOpen ' .. args)
        end)
      end, {
        nargs = 0,
        desc = 'DiffviewOpen <git-rev>^!',
      })
      --- TODO: DiffviewFileHistory %

      -- keymaps
      local opts = {
        noremap = true,
        silent = true,
      }

      vim.keymap.set('n', '<leader>do', ':DiffviewOpen<CR>', opts)
      vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>', opts)
      vim.keymap.set('n', '<leader>dp', ':DiffviewPrompt<CR>', opts)
    end,
  },
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
