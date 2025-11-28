return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- Needed for Copilot adapter integration
    'github/copilot.vim',
  },
  cmd = { 'CodeCompanion' },
  opts = function()
    -- Read env flag: set COPILOT=true in ~/.zshenv on your work machine
    local use_copilot = (vim.env.COPILOT == 'true')
    local HAIKU_MODEL = 'claude-haiku-4-5-20251001'

    -- Define custom actions
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
          -- adapter = use_copilot and 'copilot' or { name = 'ollama', model = 'qwen2.5-coder:7b' },
          adapter = use_copilot and 'copilot' or 'anthropic',
          keymaps = {
            accept_change = {
              modes = { n = 'ga' },
              description = 'Accept inline change',
            },
            reject_change = {
              modes = { n = 'gr' },
              description = 'Reject inline change',
            },
          },
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
                },
                -- max_tokens = {
                --   default = 2048, -- Limit token output
                -- },
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
      display = {
        action_palette = {
          provider = 'snacks',
          opts = {
            show_default_actions = true, -- Show built-in actions
          },
        },
      },
    }
  end,
  keys = {
    -- Normal mode: just open CodeCompanion
    { '<leader>cp', '<cmd>CodeCompanion<CR>', mode = 'n', desc = 'Inline prompt' },

    -- Visual mode: preserve the range so inline works
    { '<leader>cp', ":'<,'>CodeCompanion<CR>", mode = 'v', desc = 'Inline prompt (range)' },

    { '<leader>cc', '<cmd>CodeCompanionChat<CR>', mode = { 'n', 'v' }, desc = 'Chat prompt' },
    { '<leader>ca', '<cmd>CodeCompanionActions<CR>', mode = { 'n', 'v' }, desc = 'Actions prompt' },
  },
}
