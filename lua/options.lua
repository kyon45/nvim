-- LANGUAGE --
vim.cmd('language en_US')
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
  let &colorcolumn="80,120"
]]) -- https://stackoverflow.com/a/13731714
  -- let &colorcolumn="80,".join(range(120,999),",")

-- SEARCHING --
vim.opt.showmatch = true
vim.opt.incsearch = true          -- search as characters are entered
vim.opt.hlsearch = true
vim.opt.ignorecase = true         -- ignore case in searches by default
vim.opt.smartcase = true          -- but make it case-sensitive if an uppercase is entered

