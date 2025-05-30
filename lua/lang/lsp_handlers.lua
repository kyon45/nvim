local Module = {}

local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
  return
end

Module.capabilities = vim.lsp.protocol.make_client_capabilities()
Module.capabilities.textDocument.completion.completionItem.snippetSupport = true
Module.capabilities.textDocument.foldingRange = { -- nvim-ufo
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
Module.capabilities = cmp_nvim_lsp.default_capabilities(Module.capabilities)

-- setup
Module.setup = function()
  -- diagnostic settings
  ---@type vim.diagnostic.Opts
  local config = {
    virtual_text = false, -- disable inline virtual text
    signs = {
      ---neovim 0.11.0+
      text = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.INFO] = '',
        [vim.diagnostic.severity.HINT] = '',
      },
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      border = 'rounded',
    },
  }
  vim.diagnostic.config(config)

  -- neovim 0.11.0+
  local _hover = vim.lsp.buf.hover
  vim.lsp.buf.hover = function(opts)
    opts = opts or {}
    opts.border = opts.border or 'rounded'
    return _hover(opts)
  end

  local _signature_help = vim.lsp.buf.signature_help
  vim.lsp.buf.signature_help = function(opts)
    opts = opts or {}
    opts.border = opts.border or 'rounded'
    return _signature_help(opts)
  end
end

---@class lsp_handlers.KeymapCmd
---@field [1] string | function
---@field desc? string

---@alias lsp_handlers.KeymapTable table<string, table<string, string | function | lsp_handlers.KeymapCmd>>

--- handlers: `on_attach`
---@param bufnr integer
---@param maps? lsp_handlers.KeymapTable
local function lsp_keymaps(bufnr, maps)
  maps = maps or {}

  ---https://neovim.io/doc/user/lua.html#vim.keymap.set()
  ---Table of `:map-arguments`. Same as `nvim_set_keymap() {opts}`
  ---@class KeymapOpts: vim.api.keyset.keymap
  ---@field buffer integer | boolean Creates buffer-local mapping, `0` or `true` for current buffer.

  ---@type KeymapOpts
  local opts = { noremap = true, silent = true, buffer = bufnr }
  ---https://neovim.io/doc/user/lua.html#vim.keymap.set()
  ---@type fun(mode: string | string[], lhs: string, rhs: string | function, opts?: KeymapOpts)
  local keymap = vim.keymap.set

  ---@type lsp_handlers.KeymapTable
  local default_maps = {
    -- stylua: ignore start
    ['n'] = {
      -- Pickers
      ['gd']         = { function() Snacks.picker.lsp_definitions() end, desc = 'LSP Definitions' },
      ['gI']         = { function() Snacks.picker.lsp_implementations() end, desc = 'LSP Implementations' },
      ['gr']         = { function() Snacks.picker.lsp_references() end, desc = 'LSP References' },
      ['gs']         = { function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
      ['gD']         = { function() vim.lsp.buf.declaration() end, desc = 'LSP Declaration' },
      ['K']          = { function() vim.lsp.buf.hover() end, desc = 'LSP Hover' },
      ['gl']         = { function() vim.diagnostic.open_float() end, desc = 'Diagnostic Float' },
      ['<leader>ca'] = { function() vim.lsp.buf.code_action() end, desc = 'LSP Code Action' },
      ['<leader>r']  = { function() vim.lsp.buf.rename() end, desc = 'LSP Rename' },
      ['<leader>li'] = { function() vim.cmd('LspInfo') end, desc = 'LSP Info' },
      -- TODO
      ['<leader>lf'] = { function() vim.lsp.buf.format({ async = true }) end, desc = 'LSP Format' },
      ['<leader>lj'] = { function() vim.diagnostic.goto_next({ buffer = 0 }) end, desc = 'Next Diagnostic' },
      ['<leader>lk'] = { function() vim.diagnostic.goto_prev({ buffer = 0 }) end, desc = 'Previous Diagnostic' },
      ['<leader>lq'] = { function() vim.diagnostic.setloclist() end, desc = 'Set Diagnostic Loclist' },
      ['<leader>ls'] = { function() vim.lsp.buf.signature_help() end, desc = 'LSP Signature Help' },
    },
    -- stylua: ignore end
  }
  ---@type lsp_handlers.KeymapTable
  local keymaps_tbl = vim.tbl_deep_extend('force', default_maps, maps)
  for mode, map_maps in pairs(keymaps_tbl) do
    for keybind, cmd in pairs(map_maps) do
      local _opts = opts
      ---@type string | function
      local _cmd = ''

      local typeof_cmd = type(cmd)
      if typeof_cmd == 'string' or typeof_cmd == 'function' then
        _cmd = cmd
      else
        _opts = vim.tbl_deep_extend('force', opts, { desc = cmd.desc })
        _cmd = cmd[1]
      end

      keymap(mode, keybind, _cmd, _opts)
    end
  end
end

---@class lsp_handlers.OnAttachOpt
---@field maps? lsp_handlers.KeymapTable

---@param client any
---@param bufnr integer
---@param opts? lsp_handlers.OnAttachOpt
Module.on_attach = function(client, bufnr, opts)
  opts = opts or {}

  if client.name == 'tsserver' then
    client.server_capabilities.documentFormattingProvider = false
  end

  if client.name == 'lua_ls' then
    client.server_capabilities.documentFormattingProvider = false
  end

  lsp_keymaps(bufnr, opts.maps)
  local status_ok, illuminate = pcall(require, 'illuminate')
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
end

return Module
