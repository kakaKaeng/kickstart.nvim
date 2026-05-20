return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  branch = 'main',
  main = 'nvim-treesitter', -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    -- Autoinstall languages that are not installed
    auto_install = true,
    -- highlight = {
    --   enable = true,
    --   -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
    --   --  If you are experiencing weird indenting issues, add the language to
    --   --  the list of additional_vim_regex_highlighting and disabled languages for indent.
    --   additional_vim_regex_highlighting = { 'ruby' },
    -- },
    -- indent = { enable = true, disable = { 'ruby' } },
  },
  init = function()
    local ensureInstalled = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'go',
      'gomod',
      'gowork',
      'gosum',
      'python',
      'rust',
      'ron',
      'yaml',
    }

    -- NOTE: NEED TO INSTALL tree-sitter-cli

    local alreadyInstalled = require('nvim-treesitter.config').get_installed()
    local parsersToInstall = vim
      .iter(ensureInstalled)
      :filter(function(parser)
        return not vim.tbl_contains(alreadyInstalled, parser)
      end)
      :totable()
    require('nvim-treesitter').install(parsersToInstall)

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local treesitter = require 'nvim-treesitter'
        local lang = vim.treesitter.language.get_lang(args.match)
        if vim.list_contains(treesitter.get_available(), lang) then
          if not vim.list_contains(treesitter.get_installed(), lang) then
            treesitter.install(lang):wait()
          end
          vim.treesitter.start(args.buf)
        end
      end,
      desc = 'Enable nvim-treesitter and install parser if not installed',
    })
  end,
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
