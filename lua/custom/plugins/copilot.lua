return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {}, -- this is equalent to setup({}) function
  },
  {
    'jinh0/eyeliner.nvim',
    opts = {
      highlight_on_key = true,
      dim = false,
    }, -- this is equalent to setup({}) function
  },
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = '<M-j>',
          accept_line = '<M-l>',
          accept_word = '<M-k>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<M-c>',
        },
      },
    },
  },
}
