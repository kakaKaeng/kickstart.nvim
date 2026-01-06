vim.o.spellfile = vim.fn.stdpath 'config' .. '/spell/en.utf-8.add'

vim.api.nvim_set_hl(0, 'GitSignsAdd', { bg = '#003300' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { bg = '#333300' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { bg = '#330000' })


