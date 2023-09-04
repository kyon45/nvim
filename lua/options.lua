-- LANGUAGE --
vim.cmd('language en_US.UTF-8')
-- or: vim.api.nvim_exec('language en_US', true)

-- CLIPBOARD --
vim.opt.clipboard = 'unnamedplus' -- use system clipboard

-- MOUSE --
vim.opt.mouse = 'a'               -- allow the mouse to be used in nvim

-- TAB --
vim.opt.tabstop = 2               -- number of visual spaces per TAB
vim.opt.softtabstop = 2           -- number of spaces in tab when editing
vim.opt.expandtab = true          -- tabs are spaces

-- INDENT --
vim.opt.autoindent = true
vim.opt.shiftwidth = 2            -- width for autoindents
vim.cmd('filetype plugin indent on')
                                  -- allow auto-indenting depending on file type
-- EDITOR APPEARENCE --
vim.opt.number = true             -- show absolute line number
vim.opt.relativenumber = true     -- show relative line number
vim.opt.cursorline = true
-- vim.opt.splitbottom = true     -- open new vertical splits bottom
vim.opt.splitright = true         -- open new horizontal splits right
vim.cmd([[
  hi ColorColumn ctermbg=250 guibg=#FFFFFF
  let &colorcolumn="81,121"
]]) -- https://stackoverflow.com/a/13731714
  -- let &colorcolumn="80,".join(range(120,999),",")
  -- NOTE: hi ColorColumn would be replaced by theme
vim.opt.signcolumn = 'yes'

-- SEARCHING --
vim.opt.showmatch = true
vim.opt.incsearch = true          -- search as characters are entered
vim.opt.hlsearch = true
vim.opt.ignorecase = true         -- ignore case in searches by default
vim.opt.smartcase = true          -- but make it case-sensitive if an uppercase is entered

-- CODE FOLDING --
-- https://neovim.io/doc/user/fold.html#fold-commands
-- https://github.com/nvim-treesitter/nvim-treesitter#folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false        -- disable folding at startup 
vim.opt.foldlevel = 99

