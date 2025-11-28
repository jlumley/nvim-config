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
    local SONNET_MODEL = 'claude-sonnet-4-5-20250929'

    return {
      strategies = {
        chat = {
          adapter = use_copilot and 'copilot' or 'anthropic_sonnet',
        },
        inline = {
          adapter = use_copilot and 'copilot' or 'anthropic_haiku',
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
          anthropic_haiku = function()
            return require('codecompanion.adapters').extend('anthropic', {
              env = {
                api_key = 'ANTHROPIC_API_KEY',
              },
              schema = {
                model = {
                  default = HAIKU_MODEL,
                },
              },
            })
          end,
          anthropic_sonnet = function()
            return require('codecompanion.adapters').extend('anthropic', {
              env = {
                api_key = 'ANTHROPIC_API_KEY',
              },
              schema = {
                model = {
                  default = SONNET_MODEL,
                },
              },
            })
          end,
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
      -- Copilot adapter is built-in to CodeCompanion, works automatically
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
