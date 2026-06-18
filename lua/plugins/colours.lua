  -- Theme is chosen by $NVIM_COLORSCHEME (set by Ansible via ~/.zshenv);
  -- falls back to everforest when the env var is unset.
  local scheme = vim.env.NVIM_COLORSCHEME or "everforest"

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
    -- apply the selected scheme after the plugins above have loaded
    {
      "LazyVim/LazyVim",
      optional = true,
      init = function() vim.cmd.colorscheme(scheme) end,
    },
  }
