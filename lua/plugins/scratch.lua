return {
  'LintaoAmons/scratch.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'ibhagwan/fzf-lua' },
    { 'nvim-telescope/telescope.nvim' },
  },
  opts = {
    file_picker = 'telescope',
    filetypes = {
      'md',
      'json',
      'py',
      'go',
      'txt',
      'ts',
      'js',
      'sh',
    },
  },
}
