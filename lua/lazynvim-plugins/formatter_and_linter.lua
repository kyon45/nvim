---@class Array<T>: { [integer]: T }

---@generic T : any  -- https://luals.github.io/wiki/annotations/#generic
---@param arr Array<T>
---@param val T
---@return boolean
local function contains(arr, val)
  for _idx, v in pairs(arr) do
    if v == val then
      return true
    end
  end
  return false
end

-- https://www.josean.com/posts/neovim-linting-and-formatting
return {
  -- Formatter
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local conform = require('conform')

      ---@param skip_filename boolean | nil
      local function gen_fmt_opt_fn(skip_filename)
        skip_filename = skip_filename == nil and false or skip_filename

        -- :help conform.format
        ---@param bufnr integer | nil
        ---@diagnostic disable-next-line
        local fmt_opt_fn = function(bufnr)
          -- [feat: Command to disable formatting #192](https://github.com/stevearc/conform.nvim/issues/192)
          if vim.g.disable_autoformat or (bufnr and vim.b[bufnr].disable_autoformat) then
            return -- nil, to prevent auto_format
            ---FIXME: manaully format is not affected
          end

          ---@type conform.FormatOpts
          local fmt_opt = {
            bufnr = bufnr,
            lsp_fallback = true, -- tell conform.nvim to use the lsp of no formatter is available
            async = false, -- means to not do asynchronous formatting
          }

          local JTSX_TIMEOUT = 1000
          local DEFAULT_TIMEOUT = 500
          ---@type table<string, integer>
          local filetype_timeout_map = {
            javascript = JTSX_TIMEOUT,
            typescript = JTSX_TIMEOUT,
            javascriptreact = JTSX_TIMEOUT,
            typescriptreact = JTSX_TIMEOUT,
          }

          --- to get current buffer's number    |  `:echo bufnr('%')`
          --- to get filetype of buffer         |  `:echo getbufvar(some_bufnr, '&filetype')`
          --- to get filetype of current buffer |  `:lua print(vim.bo.filetype)`
          local filetype = vim.bo.filetype
          fmt_opt.timeout_ms = filetype_timeout_map[filetype] or DEFAULT_TIMEOUT

          --- see `:h expand`
          local filename = vim.fn.expand('%:t')
          ---@type Array<string>
          local IGNORED_FILENAMES = {
            'lazy-lock.json',
          }
          if skip_filename and contains(IGNORED_FILENAMES, filename) then
            vim.notify('NEVER format "' .. filename .. '" on save')
            fmt_opt.dry_run = true -- Prevent format
          end

          return fmt_opt
        end

        return fmt_opt_fn
      end

      local fmt_opt_fn_on_save = gen_fmt_opt_fn(true)
      local fmt_opt_fn_manual = gen_fmt_opt_fn(false)

      -- ensure to install these formatters (by `Mason` for example)
      local prettier = { 'prettier' }
      conform.setup({
        formatters_by_ft = {
          -- Prettier
          javascript = prettier,
          typescript = prettier,
          javascriptreact = prettier,
          typescriptreact = prettier,
          css = prettier,
          html = prettier,
          json = prettier,
          yaml = prettier,
          markdown = prettier,
          -- Lua
          lua = { 'stylua' }, -- https://github.com/JohnnyMorganz/StyLua, stylua.toml
        },
        format_on_save = fmt_opt_fn_on_save,
      })

      -- regiter user_command
      ---@param cmd 'toggle' | 'disable' | 'enable'
      ---@param scope 'b' | 'g'
      local perform_autoformat_cmd = function(cmd, scope)
        --perform update
        local origin_disable_autoformat = false
        local disable_autoformat = false
        if scope == 'g' then
          origin_disable_autoformat = vim.g.disable_autoformat
          if cmd == 'toggle' then
            vim.g.disable_autoformat = not origin_disable_autoformat
          elseif cmd == 'disable' then
            vim.g.disable_autoformat = true
          else
            vim.g.disable_autoformat = false
          end
          disable_autoformat = vim.g.disable_autoformat
        else
          origin_disable_autoformat = vim.b.disable_autoformat
          if cmd == 'toggle' then
            vim.b.disable_autoformat = not origin_disable_autoformat
          elseif cmd == 'disable' then
            vim.b.disable_autoformat = true
          else
            vim.b.disable_autoformat = false
          end
          disable_autoformat = vim.b.disable_autoformat
        end

        --notify
        local tag_onoff = 'on'
        if disable_autoformat then
          tag_onoff = 'off'
        end

        vim.notify('[AutoFormat] ' .. cmd .. ' :<' .. scope .. '>' .. tag_onoff)
      end

      vim.api.nvim_create_user_command('AutoFormatToggle', function(args)
        if args.bang then
          perform_autoformat_cmd('toggle', 'g')
        else
          perform_autoformat_cmd('toggle', 'b')
        end
      end, {
        desc = 'Toggle autoformat-on-save',
        bang = true, -- allows the ! variant
      })

      vim.api.nvim_create_user_command('AutoFormatDisable', function(args)
        if args.bang then
          -- :AutoFormatDisable! disables autoformat for this buffer only
          perform_autoformat_cmd('disable', 'g')
        else
          -- :AutoFormatDisable disables auto-format globally
          perform_autoformat_cmd('disable', 'b')
        end
      end, {
        desc = 'Disable autoformat-on-save',
        bang = true, -- allows the ! variant
      })

      vim.api.nvim_create_user_command('AutoFormatEnable', function()
        perform_autoformat_cmd('enable', 'g')
        perform_autoformat_cmd('enable', 'b')
      end, {
        desc = 'Re-enable autoformat-on-save',
      })

      -- keymap "MakePretty"
      vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
        conform.format(fmt_opt_fn_manual())
      end, { desc = 'Format file or range (in visual mode)' })
    end,
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require('lint')

      ---Step 1 `:MasonInstall eslint_d@13.1.2`
      ---Step 2 `:!eslint_d restart`
      ---@see https://www.reddit.com/r/neovim/comments/1g0gbli/comment/lr92iqe
      local eslint_linter = { 'eslint_d' }
      lint.linters_by_ft = {
        javascript = eslint_linter,
        typescript = eslint_linter,
        javascriptreact = eslint_linter,
        typescriptreact = eslint_linter,
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set('n', '<leader>l', function()
        lint.try_lint()
      end, { desc = 'Trigger linting for current file' })
    end,
  },
}
