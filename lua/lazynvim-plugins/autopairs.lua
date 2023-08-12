-- https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/autopairs.lua
return {
  {
    'windwp/nvim-autopairs',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    config = function()
      local npairs = require('nvim-autopairs')
      npairs.setup({})

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp_status_ok, cmp = pcall(require, 'cmp')
      if not cmp_status_ok then
        return
      end
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  }
}

