return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    opts = {
      -- suggestion = {
      --   auto_trigger = true,
      --   keymap = {
      --     accept = '<M-j>',
      --     accept_line = '<M-l>',
      --     accept_word = '<M-k>',
      --     next = '<M-]>',
      --     prev = '<M-[>',
      --     dismiss = '<M-c>',
      --   },
      -- },
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
}
