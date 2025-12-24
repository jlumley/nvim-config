return {
  {
    'rest-nvim/rest.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, 'http')
      end,
    },
    ft = { 'http' },
    config = function()
      vim.keymap.set('n', '<leader>sr', function()
        vim.cmd 'Rest run'
      end, { desc = 'Rest [S]end [R]equest' })

      vim.g.rest_nvim = {
        request = {
          -- skip_ssl_verification = true,
        },
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
      }
    end,
  },
}
