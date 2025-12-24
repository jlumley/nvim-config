return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'github/copilot.vim',
  },
  cmd = { 'CodeCompanion' },
  opts = function()
    -- Model configuration
    local MAX_OUTPUT_TOKENS = 2000
    local HAIKU_MODEL = 'claude-haiku-4-5-20251001'
    -- local GEMINI_MODEL = 'gemini-2.5-flash-lite'
    local GEMINI_MODEL = 'gemini-3-flash-preview'

    -- Read env flag: set COPILOT=true in ~/.zshenv on your work machine
    local use_copilot = (vim.env.COPILOT == 'true')

    -- Docs pattern: adapter can be a table { name = "..", model = ".." }
    -- https://codecompanion.olimorris.dev/configuration/adapters#changing-a-model
    local chat_adapter = use_copilot and 'copilot'
      or {
        -- name = 'anthropic',
        -- model = HAIKU_MODEL,
        name = 'gemini',
        model = GEMINI_MODEL,
      }

    local inline_adapter = use_copilot and 'copilot' or {
      name = 'gemini',
      model = GEMINI_MODEL,
    }

    return {
      strategies = {
        chat = {
          adapter = chat_adapter,
          opts = {
            -- some adapters honour this; harmless if ignored
            max_output_tokens = MAX_OUTPUT_TOKENS,
          },
        },
        inline = {
          adapter = inline_adapter,
          opts = {
            max_output_tokens = MAX_OUTPUT_TOKENS,
          },
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

      -- NOTE: no `adapters = { http = ... }` block here

      display = {
        action_palette = {
          provider = 'snacks',
          opts = {
            show_default_actions = true,
          },
        },
      },
      opts = {
        -- Enable this if you want to sanity-check which adapter/model is actually used
        -- log_level = 'DEBUG',
      },
    }
  end,
  keys = {
    {
      '<leader>cp',
      ':%CodeCompanion<CR>',
      mode = 'n',
      desc = 'Inline prompt (whole file)',
    },
    { '<leader>cp', ":'<,'>CodeCompanion<CR>", mode = 'v', desc = 'Inline prompt (range)' },
    { '<leader>cc', '<cmd>CodeCompanionChat<CR>', mode = { 'n', 'v' }, desc = 'Chat prompt' },
    { '<leader>ca', '<cmd>CodeCompanionActions<CR>', mode = { 'n', 'v' }, desc = 'Actions prompt' },
  },
}
