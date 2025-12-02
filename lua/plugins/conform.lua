-- filepath: lua/custom/plugins/conform.lua
return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,

    -- Configure format-on-save behavior
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true, typescript = true }
      local lsp_format_opt = disable_filetypes[vim.bo[bufnr].filetype] and 'never' or 'fallback'

      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,

    -- Formatter configuration by file type
    formatters_by_ft = {
      -- Scripting languages
      lua = { 'stylua' },
      python = { 'black' },
      bash = { 'shfmt' },

      -- Web development (runs in order, use multiple for fallback)
      typescript = { 'prettierd', 'prettier' },
      -- javascript = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}
