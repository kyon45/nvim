-- https://github.com/neovim/neovim/issues/21686#issuecomment-1522446128
-- https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/lsp/settings/lua_ls.lua
return {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        global = {
          'vim',
          'require'
        }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enabled = false,
      },
    }
  }
}
