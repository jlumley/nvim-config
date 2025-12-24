return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('harpoon').setup {
      global_settings = {
        save_on_toggle = false,
        save_on_change = true,
      },
    }

    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    vim.keymap.set('n', '<leader>j', mark.add_file, { desc = 'Harpoon: Add file to list' })
    vim.keymap.set('n', '<leader>k', ui.toggle_quick_menu, { desc = 'Harpoon: Toggle menu' })
    vim.keymap.set('n', '<leader>u', function()
      ui.nav_file(1)
    end, { desc = 'Harpoon: Select file 1' })
    vim.keymap.set('n', '<leader>i', function()
      ui.nav_file(2)
    end, { desc = 'Harpoon: Select file 2' })
    vim.keymap.set('n', '<leader>o', function()
      ui.nav_file(3)
    end, { desc = 'Harpoon: Select file 3' })
    vim.keymap.set('n', '<leader>p', function()
      ui.nav_file(4)
    end, { desc = 'Harpoon: Select file 4' })
  end,
}
