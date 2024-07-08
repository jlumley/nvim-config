-- Define a function to format the current buffer with bean-format
local function file_format()
  local current_ft = vim.bo.filetype
  local current_line = vim.fn.line '.'
  if current_ft == 'beancount' then
    vim.cmd ':%!bean-format'
  else
    vim.lsp.buf.format()
  end
  vim.api.nvim_win_set_cursor(0, { current_line, 0 })
end

vim.keymap.set('n', '<leader>f', file_format, { noremap = true, silent = true })
-- move highlight with J K
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- keep cursor centered while hoping
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', 'G', 'Gzz')

-- delete and paste without saving to register
vim.keymap.set('x', '<leader>p', [["_dP]])

-- yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- delete to void register
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])
