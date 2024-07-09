return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      -- adding new entry
      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Add new harpoon entry' })
      -- open quick menu
      vim.keymap.set('n', '<leader>m', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      -- select index 1
      vim.keymap.set('n', '<leader>j', function()
        harpoon:list():select(1)
      end)
      -- select index 2
      vim.keymap.set('n', '<leader>k', function()
        harpoon:list():select(2)
      end)
      -- select index 3
      vim.keymap.set('n', '<leader>l', function()
        harpoon:list():select(3)
      end)
      -- select index 4
      vim.keymap.set('n', "<leader>'", function()
        harpoon:list():select(4)
      end)
    end,
  },
}
