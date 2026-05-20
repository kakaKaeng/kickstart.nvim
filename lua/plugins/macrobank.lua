return {
  'sahilsehwag/macrobank.nvim',
  config = function()
    require('macrobank').setup()
    vim.keymap.set('n', '<leader>mm', function()
      require('macrobank.editor').open()
    end, { desc = '[Macrobank]: Edit macros' })
    vim.keymap.set('n', '<leader>mb', function()
      require('macrobank.bank_editor').open()
    end, { desc = '[MacroBank] Edit saved macros' })
  end,
}
