return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  opts = {
    -- add any custom options here
    dir = vim.fn.stdpath 'state' .. '/sessions/', -- directory where session files are saved
    -- minimum number of file buffers that need to be open to save
    -- Set to 0 to always save
    need = 1,
    branch = true, -- use git branch to save session
  },
  config = function()
    require('persistence').setup()

    -- load the session for the current directory
    vim.keymap.set('n', '<leader>lS', function()
      require('persistence').load()
    end, { desc = '[L]oad [S]ession' })

    -- select a session to load
    vim.keymap.set('n', '<leader>ls', function()
      require('persistence').select()
    end, { desc = '[L]oad [S]elect session' })

    -- load the last session
    vim.keymap.set('n', '<leader>ll', function()
      require('persistence').load { last = true }
    end, { desc = '[L]oad [L]ast session' })

    -- stop Persistence => session won't be saved on exit
    vim.keymap.set('n', '<leader>ld', function()
      require('persistence').stop()
    end, { desc = '[L] [D]elete session' })
  end,
}
