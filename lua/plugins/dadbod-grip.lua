return {
  'joryeugene/dadbod-grip.nvim',
  version = 'v1.10.0',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  keys = {
    { '<leader>tu', '<cmd>GripConnect<cr>', desc = '[T]oggle [U]I DB' },
    -- qpad_execute = '<C-s>',
  },
  opts = {
    picker = 'telescope',
    completion = false,
    limit = 100,
    ai = false,
  },
}
