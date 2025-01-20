return {
  {
    'rest-nvim/rest.nvim',
    config = function()
      -- first load extension
      require('telescope').load_extension 'rest'
      -- then use it, you can also use the `:Telescope rest select_env` command
      -- require('telescope').extensions.rest.select_env()

      vim.keymap.set('n', '<leader>rr', function()
        vim.cmd 'Rest run'
      end, { desc = '[R]est [R]un request' })

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
