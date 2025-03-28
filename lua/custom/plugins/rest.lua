return {
  {
    'rest-nvim/rest.nvim',
    ft = { 'http' },
    config = function()
      -- first load extension
      -- then use it, you can also use the `:Telescope rest select_env` command
      -- require('telescope').extensions.rest.select_env()

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
