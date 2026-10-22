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
  config = function(_, opts)
    require('scratch').setup(opts)

    -- Sorted ScratchOpen: latest-modified files on top (empty prompt).
    -- Upstream `open_scratch_telescope()` calls find_files with no ordering,
    -- while the fzf/snacks/vim_ui pickers all sort by mtime. Mirror the fzf
    -- approach with `rg --files --sortr modified`.
    vim.keymap.set('n', '<leader>ss', function()
      local ok, builtin = pcall(require, 'telescope.builtin')
      if not ok then
        vim.notify('ScratchOpen needs telescope.nvim', vim.log.levels.ERROR)
        return
      end

      local cfg = vim.g.scratch_config
      local scratch_dir = cfg and cfg.scratch_file_dir
      if not scratch_dir then
        vim.notify('scratch.nvim not configured', vim.log.levels.ERROR)
        return
      end
      if vim.fn.isdirectory(scratch_dir) == 0 then
        vim.fn.mkdir(scratch_dir, 'p')
      end

      local keys = cfg.picker_keys or {}
      local delete_key = keys.delete or '<C-x>'

      local find_command
      if vim.fn.executable 'rg' == 1 then
        find_command = { 'rg', '--files', '--sortr', 'modified' }
      end

      builtin.find_files {
        cwd = scratch_dir,
        find_command = find_command,
        attach_mappings = function(prompt_bufnr, map)
          map('n', delete_key, function()
            require('scratch.telescope_actions').delete_item(prompt_bufnr)
          end)
          return true
        end,
      }
    end, { noremap = true, silent = true, desc = '[S]earch [S]cratch (recent first)' })
  end,
}
