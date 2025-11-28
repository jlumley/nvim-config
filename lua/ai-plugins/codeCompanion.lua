return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- Needed for Copilot adapter integration
    'github/copilot.vim',
  },

  opts = function()
    -- Read env flag: set COPILOT=true in ~/.zshenv on your work machine
    local use_copilot = (vim.env.COPILOT == 'true')
    local HAIKU_MODEL = 'claude-haiku-4-5-20251001'

    return {
      strategies = {
        -- Chat:
        --  - If COPILOT=true → use Copilot
        --  - Else → Anthropic (your existing Claude setup)
        chat = {
          adapter = use_copilot and 'copilot' or 'anthropic',
        },

        -- Inline:
        --  - If COPILOT=true → Copilot inline
        --  - Else → Ollama (your local qwen2.5-coder:7b)
        inline = {
          adapter = use_copilot and 'copilot' or { name = 'ollama', model = 'qwen2.5-coder:7b' },
        },
      },

      adapters = {
        http = {
          -- Anthropic adapter (Claude)
          anthropic = function()
            return require('codecompanion.adapters').extend('anthropic', {
              env = {
                api_key = 'ANTHROPIC_API_KEY',
              },
              schema = {
                model = {
                  default = HAIKU_MODEL,
                  max_tokens = 1024, -- Limit token output
                },
              },
            })
          end,

          -- Ollama adapter (your local model)
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

        -- Copilot adapter is built-in to CodeCompanion, works automatically
      },
    }
  end,

  keys = {
    { '<leader>cp', '<cmd>CodeCompanion<CR>', desc = 'Open [C]ompanion [P]rompt' },
    { '<leader>cc', '<cmd>CodeCompanionChat<CR>', desc = 'Open [C]ompanion [C]hat' },
    { '<leader>ca', '<cmd>CodeCompanionActions<CR>', desc = '[C]ompanion [A]ctions' },
  },
}
