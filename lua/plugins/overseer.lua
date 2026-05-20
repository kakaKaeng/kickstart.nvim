return {
  'stevearc/overseer.nvim',
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {},
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>to', ':OverseerToggle<CR>', { noremap = true, desc = '[T]oggle [O]verseer' })
    vim.api.nvim_set_keymap('n', '<leader>or', ':OverseerRun<CR>', { noremap = true, desc = '[O]verseer [R]un' })
  end,
}
