-- Theme is chosen by $NVIM_COLORSCHEME (set by Ansible via ~/.zshenv);
-- falls back to everforest when the env var is unset.
local scheme = vim.env.NVIM_COLORSCHEME or 'everforest'

-- All colorscheme plugins below are `lazy = false`, so they are on the
-- runtimepath by VimEnter. Apply the chosen scheme then (pcall so a missing
-- plugin can't break startup).
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    pcall(vim.cmd.colorscheme, scheme)
  end,
})

return {
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_enable_italic = true
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
  },
}
