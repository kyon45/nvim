-- define common options
local opts = {
  noremap = true, -- non-recursive
  silent = true,
}

-- NORMAL MODE ----------------------------------------------------------------
-- window navigation 用 <C-h/j/k/l> 快速在多窗口之间移动光标
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- resize window with arrows
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical +2<CR>', opts)

-- VISUAL MODE ----------------------------------------------------------------
-- 模式下可以一直用 Tab 或者 Shift-Tab 改变缩进
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- TERMINAL MODE ---------------------------------------------------------------
-- Type <S-Space> but got ;2u issue
-- https://github.com/vim/vim/issues/6040#issuecomment-827176487
vim.keymap.set('t', '<S-Space>', '<Space>', opts)

-- <LEADER> KEY ---------------------------------------------------------------
vim.g.mapleader = ','
