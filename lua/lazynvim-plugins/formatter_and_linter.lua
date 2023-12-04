-- https://www.josean.com/posts/neovim-linting-and-formatting
return {
  -- Formatter
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      -- :help conform.format
      local fmt_opt = {
        lsp_fallback = true, -- tell conform.nvim to use the lsp of no formatter is available
        async = false, -- means to not do asynchronous formatting
        timeout_ms = 500, -- meas to timeout after 500ms if formatting isn's finished
      }

      -- ensure to install these formatters (by `Mason` for example)
      local prettier = { "prettier" }
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
          lua = { "stylua" }, -- https://github.com/JohnnyMorganz/StyLua, stylua.toml
        },
        format_on_save = fmt_opt,
      })

      -- keymap "MakePretty"
      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format(fmt_opt)
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      local eslint_d = { "eslint_d" }
      lint.linters_by_ft = {
        javascript = eslint_d,
        typescript = eslint_d,
        javascriptreact = eslint_d,
        typescriptreact = eslint_d,
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
}
