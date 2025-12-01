-- Keymaps for moving highlighted lines in visual mode
-- J and K move selected lines up/down and preserve the selection (gv=gv)
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Keymaps to keep the cursor centered (zz) during motion/search
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- Half-page down, centered
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- Half-page up, centered
vim.keymap.set('n', 'n', 'nzz') -- Next search result, centered
vim.keymap.set('n', 'N', 'Nzz') -- Previous search result, centered
vim.keymap.set('n', 'G', 'Gzz') -- Go to last line, centered

-- Plugin keymaps: Telescope Todo comments
vim.keymap.set('n', '<leader>st', ':TodoTelescope<CR>', { desc = '[S]earch [T]odo comments' })

-- Utility: Clear search highlight
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps (LSP/Linter integration)
vim.keymap.set('n', '<leader>D', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Terminal mode keymap
vim.keymap.set('t', '<Esc><Esc>', '<C-><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation keymaps (Ctrl + hjkl)
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
