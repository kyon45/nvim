-- https://www.josean.com/posts/neovim-linting-and-formatting
return {
  -- Formatter
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local conform = require('conform')

      -- :help conform.format
      ---@param bufnr integer | nil
      ---@diagnostic disable-next-line
      local fmt_opt_fn = function(bufnr)
        ---@type conform.FormatOpts
        local fmt_opt = {
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

        return fmt_opt
      end

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
        format_on_save = fmt_opt_fn,
      })

      -- keymap "MakePretty"
      vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
        conform.format(fmt_opt_fn())
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
