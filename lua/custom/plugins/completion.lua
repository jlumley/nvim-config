return {

  -- Completion UI
  {
    'Saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'nvim-lua/plenary.nvim',
    },
    event = 'InsertEnter',
    config = function()
      -- Load snippets from friendly-snippets (VS Code format)
      require('luasnip.loaders.from_vscode').lazy_load()

      -- Optional: Load project snippets (LuaSnip format) located in ./snippets
      local snippets_dir = vim.fn.getcwd() .. '/snippets'
      if vim.fn.isdirectory(snippets_dir) == 1 then
        require('luasnip.loaders.from_lua').lazy_load { paths = { snippets_dir } }
        vim.notify('Loaded project snippets', vim.log.levels.INFO)
      end

      -- blink.cmp setup
      require('blink.cmp').setup {
        snippets = {
          preset = 'luasnip', -- Use LuaSnip integration
        },
        keymap = {
          preset = 'default',
        },
        sources = {
          -- Prioritize snippets, then LSP, path, and buffer completion
          default = { 'snippets', 'lsp', 'path', 'buffer' },
        },
        completion = {
          -- Pre-fetch candidates when entering insert mode to reduce lag
          trigger = { prefetch_on_insert = true },
        },
        appearance = {
          -- Use nvim-cmp UI compatibility mode
          use_nvim_cmp_as_default = true,
        },
      }
    end,
  },
}
