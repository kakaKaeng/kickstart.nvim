return {
  'LintaoAmons/scratch.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'ibhagwan/fzf-lua' },
    { 'nvim-telescope/telescope.nvim' },
  },
  opts = {
    file_picker = 'telescope',
    filetypes = {"js", "sh", "ts", "py", "go", "txt", "md", "json"}
  },
}
