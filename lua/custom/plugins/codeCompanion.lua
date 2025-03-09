return {
  'olimorris/codecompanion.nvim',
  config = function()
    require('codecompanion').setup {
      strategies = {
        chat = {
          adapter = 'copilot',
        },
        inline = {
          adapter = 'copilot',
        },
      },
    }
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'zbirenbaum/copilot.lua',
  },
  vim.keymap.set('n', '<leader>cp', '<cmd>CodeCompanion<CR>', { desc = 'Open [C]ompanion [P]rompt' }),
  vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat<CR>', { desc = 'Open [C]ompanion [C]hat' }),
}
