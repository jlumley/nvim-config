return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      direction = 'float',
    },
  },
  vim.keymap.set('n', '<leader>tt', ':ToggleTerm direction=float<CR>', { noremap = true, silent = true, desc = 'Open [F]loating [T]erminal window' }),
  vim.keymap.set('t', '<leader>tt', [[<C-\><C-n>:ToggleTerm<CR>]], { noremap = true, silent = true, desc = 'Minimize [F]loating [T]erminal window' }),
}
