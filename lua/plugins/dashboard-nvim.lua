return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  opts = function()
    local splash = require('milli').load { splash = 'blackhole' }
    return {
      theme = 'hyper',
      config = {
        header = splash.frames[1], -- seed header with frame 0
        shortcut = {
          {
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = 'Quit',
            group = 'Label',
            action = 'q',
            key = 'q',
          },
        },
        project = {
          enable = false,
        },
        mru = {
          enable = false,
        },
        footer = {},
      },
    }
  end,
  config = function(_, opts)
    require('dashboard').setup(opts)
    require('milli').dashboard { splash = 'blackhole', loop = true }
  end,
  dependencies = { 'nvim-tree/nvim-web-devicons', 'amansingh-afk/milli.nvim' },
}
