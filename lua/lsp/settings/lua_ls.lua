-- https://github.com/neovim/neovim/issues/21686#issuecomment-1522446128
-- https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/lsp/settings/lua_ls.lua
return {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths here.
          '${3rd}/luv/library',
          -- "${3rd}/busted/library",
        },
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enabled = false,
      },
      -- Close default formatter, use `conform.nvim` instead
      format = {
        enabled = false,
      },
    },
  },
}
