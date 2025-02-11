return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  vim.keymap.set('n', '<leader>cp', '<cmd>CodeCompanion<CR>', { desc = 'Open [C]ompanion [P]rompt' }),
  vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat<CR>', { desc = 'Open [C]ompanion [C]hat' }),
}
