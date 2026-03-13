return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_auto_execute_table_helpers = 1

    local config = require 'db_config'
    vim.g.dbs = vim.list_extend(vim.deepcopy(config), {})

    --- Keymaps
    vim.api.nvim_set_keymap('n', '<leader>tu', ':DBUIToggle<CR>', { noremap = true, desc = '[T]oggle [U]I DB' })
  end,
}
