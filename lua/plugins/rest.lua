return {
  {
    'rest-nvim/rest.nvim',
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
