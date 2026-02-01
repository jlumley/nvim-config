-- lua/custom/plugins/treesitter.lua
return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'c',
          'diff',
          'html',
          'lua',
          'luadoc',
          'markdown',
          'markdown_inline',
          'query',
          'vim',
          'vimdoc',
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = { enable = true, disable = { 'ruby' } },
      }

      -- Manual textobject keymaps
      local select = require('nvim-treesitter-textobjects.select').select_textobject
      vim.keymap.set({ 'x', 'o' }, 'af', function()
        select('@function.outer', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'if', function()
        select('@function.inner', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'ac', function()
        select('@class.outer', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'ic', function()
        select('@class.inner', 'textobjects')
      end)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
  },
}
