return {

  -- Completion UI
  {
    'Saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'nvim-lua/plenary.nvim',
      'milanglacier/minuet-ai.nvim',
    },
    event = 'InsertEnter',
    config = function()
      -- Load snippets from friendly-snippets
      require('luasnip.loaders.from_vscode').lazy_load()

      -- Optional: Load project snippets
      local cwd = vim.fn.getcwd()
      local snippets_dir = cwd .. '/snippets'
      if vim.fn.isdirectory(snippets_dir) == 1 then
        require('luasnip.loaders.from_lua').lazy_load { paths = { snippets_dir } }
        vim.notify('Loaded project snippets', vim.log.levels.INFO)
      end

      -- Minuet (Ollama / FIM)
      require('minuet').setup {
        provider = 'openai_fim_compatible',
        n_completions = 1,
        context_window = 128,
        request_timeout = 3,
        provider_options = {
          openai_fim_compatible = {
            name = 'Ollama',
            end_point = 'http://localhost:11434/v1/completions',
            model = 'qwen2.5-coder:7b',
            api_key = 'TERM', -- dummy
            optional = {
              max_tokens = 64,
              top_p = 0.9,
            },
          },
        },
      }

      -- blink.cmp setup
      require('blink.cmp').setup {
        snippets = {
          preset = 'luasnip',
        },
        keymap = {
          preset = 'default',
        },
        sources = {
          default = { 'snippets', 'lsp', 'path', 'buffer', 'minuet' },
          -- default = { 'minuet' },
          providers = {
            minuet = {
              name = 'minuet',
              module = 'minuet.blink',
              async = true,
              timeout_ms = 3000,
              score_offset = 50,
            },
          },
        },
        completion = {
          trigger = { prefetch_on_insert = true }, -- don’t auto-fire AI
        },
        appearance = {
          use_nvim_cmp_as_default = true,
        },
      }
    end,

    -- Map <C-Space> to trigger Minuet AI completions
    vim.api.nvim_set_keymap(
      'i', -- Insert mode
      '<C-Space>', -- Keybinding
      "<cmd>lua require('minuet').complete()<CR>", -- Command to run
      { noremap = true, silent = true } -- Options
    ),
  },
}
