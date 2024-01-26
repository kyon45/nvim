local saga_status_ok, saga = pcall(require, 'lspsaga')
if not saga_status_ok then
  return
end

saga.setup({
  ui = {
    border = 'rounded',
  },
  lightbulb = {
    enable = false,
  },
})

-- Keymap
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local bufnr = args.buf

    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local common_opts = { noremap = true, silent = true }
    -- https://neovim.io/doc/user/api.html#nvim_buf_set_keymap()
    local keymap = function(mode, lhs, rhs, opts)
      local _opts = vim.tbl_deep_extend('force', common_opts, opts or {})
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, _opts)
    end
    keymap('n', '<leader>o', '<cmd>Lspsaga outline<CR>', {})
    keymap('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', {})
    keymap('n', '<leader>r', '<cmd>Lspsaga rename<CR>', {})
    keymap('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', {})
    keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {})
    keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', {})
    keymap('n', 'gI', '<cmd>Telescope lsp_implementations<CR>', {})
    keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', {})
    keymap('n', 'gl', '<cmd>Lspsaga show_line_diagnostics<CR>', {})
  end,
})

-- diagnostic settings
local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

local config = {
  virtual_text = false, -- disable inline virtual text
  signs = {
    active = signs, -- show signs
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  -- float = {},
}
vim.diagnostic.config(config)
