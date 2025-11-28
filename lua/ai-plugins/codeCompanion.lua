return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    strategies = {
      -- Use Claude for chat (more capable for complex discussions)
      chat = {
        adapter = 'anthropic',
      },
      -- Use Ollama for inline (faster, local, no API costs)
      inline = {
        adapter = { name = 'ollama', model = 'qwen2.5-coder:7b' },
      },
    },
    adapters = {
      http = {
        -- Claude/Anthropic adapter
        anthropic = function()
          return require('codecompanion.adapters').extend('anthropic', {
            env = {
              api_key = 'ANTHROPIC_API_KEY', -- Reads from environment variable
            },
            schema = {
              model = {
                default = 'claude-sonnet-4-20250514', -- Latest Sonnet 4.5
              },
            },
          })
        end,
        -- Your existing Ollama adapter
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            opts = { stream = true },
            schema = {
              num_ctx = { default = 16384 },
              keep_alive = { default = '5m' },
            },
          })
        end,
      },
    },
  },
  keys = {
    { '<leader>cp', '<cmd>CodeCompanion<CR>', desc = 'Open [C]ompanion [P]rompt' },
    { '<leader>cc', '<cmd>CodeCompanionChat<CR>', desc = 'Open [C]ompanion [C]hat' },
    { '<leader>ca', '<cmd>CodeCompanionActions<CR>', desc = '[C]ompanion [A]ctions' },
  },
}
