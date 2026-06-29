return {
  'nickjvandyke/opencode.nvim',
  version = '*', -- Latest stable release
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      'folke/snacks.nvim',
      optional = true,
      opts = {
        lsp = {
          enabled = true,
        },
        input = {}, -- Enhances `ask()`
        picker = { -- Enhances `select()`
          actions = {
            opencode_send = function(...)
              return require('opencode').snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
              },
            },
          },
        },
      },
    },
  },
  keys = {
    {
      '<leader>oa',
      function()
        require('opencode').ask()
      end,
      desc = '[O]pencode [A]sk',
      mode = 'n',
    },
    {
      '<leader>oa',
      function()
        require('opencode').ask '@selection: '
      end,
      desc = '[O]pencode [A]sk about selection',
      mode = 'v',
    },
    {
      '<leader>ot',
      function()
        require('opencode').toggle()
      end,
      desc = '[O]pencode [T]oggle',
      mode = 'n',
    },
    {
      '<leader>of',
      function()
        require('opencode').ask '@this: '
      end,
      desc = '[O]pencode Ask [F]ile',
      mode = 'n',
    },
    {
      '<leader>os',
      function()
        require('opencode').select()
      end,
      desc = '[O]pencode [S]elect',
      mode = 'n',
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any; goto definition on the type or field for details
    }

    vim.o.autoread = true -- Required for `opts.events.reload`

    -- Recommended/example keymaps
    -- vim.keymap.set({ 'n', 'x' }, '<C-a>', function()
    --   require('opencode').ask('@this: ', { submit = true })
    -- end, { desc = 'Ask opencode…' })
    -- vim.keymap.set({ 'n', 'x' }, '<C-x>', function()
    --   require('opencode').select()
    -- end, { desc = 'Execute opencode action…' })
    -- vim.keymap.set({ 'n', 't' }, '<C-.>', function()
    --   require('opencode').toggle()
    -- end, { desc = 'Toggle opencode' })

    vim.keymap.set({ 'n', 'x' }, 'go', function()
      return require('opencode').operator '@this '
    end, { desc = 'Add range to opencode', expr = true })
    vim.keymap.set('n', 'goo', function()
      return require('opencode').operator '@this ' .. '_'
    end, { desc = 'Add line to opencode', expr = true })

    -- vim.keymap.set('n', '<S-C-u>', function()
    --   require('opencode').command 'session.half.page.up'
    -- end, { desc = 'Scroll opencode up' })
    -- vim.keymap.set('n', '<S-C-d>', function()
    --   require('opencode').command 'session.half.page.down'
    -- end, { desc = 'Scroll opencode down' })

    -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
    vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment under cursor', noremap = true })
    vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement under cursor', noremap = true })
  end,
}
