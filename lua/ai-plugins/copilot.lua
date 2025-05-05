return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = false,
      },
      panel = {
        enabled = false,
      },
      copilot_model = 'gpt-4o-copilot',
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
}
