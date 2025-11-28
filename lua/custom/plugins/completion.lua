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
      -- Load snippets from friendly-snippets
      require('luasnip.loaders.from_vscode').lazy_load()

      -- Optional: Load project snippets
      local cwd = vim.fn.getcwd()
      local snippets_dir = cwd .. '/snippets'
      if vim.fn.isdirectory(snippets_dir) == 1 then
        require('luasnip.loaders.from_lua').lazy_load { paths = { snippets_dir } }
        vim.notify('Loaded project snippets', vim.log.levels.INFO)
      end

      -- blink.cmp setup
      require('blink.cmp').setup {
        snippets = {
          preset = 'luasnip',
        },
        keymap = {
          preset = 'default',
        },
        sources = {
          default = { 'snippets', 'lsp', 'path', 'buffer' },
          -- default = { 'minuet' },
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
