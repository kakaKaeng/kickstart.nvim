return {
  '0xfraso/nvim-listchars',
  opts = true,
  config = function()
    require('nvim-listchars').setup {
      save_state = true,
      listchars = {
        trail = '·',
        nbsp = '␣',
        tab = '» ',
        space = '·',
      },
      notifications = true,
      exclude_filetypes = {
        'markdown',
      },
      lighten_step = 10,
    }

    vim.api.nvim_set_keymap('n', '<leader>tl', ':ListcharsToggle<CR>', { noremap = true, desc = '[T]oggle [L]istchars' })
  end,
}
