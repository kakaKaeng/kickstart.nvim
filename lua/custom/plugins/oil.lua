return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local oil = require 'oil'
    oil.setup {
      float = {
        max_width = 0.5,
        max_height = 0.7,
        padding = 2,
      },
    }
    vim.keymap.set('n', '<leader>-', oil.toggle_float, { desc = 'Open parent directory' })

    oil.toggle_hidden()
  end,
}
