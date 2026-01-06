-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- you can provide additional configuration to the handlers,
      -- see mason-nvim-dap readme for more information
      handlers = {},

      -- you'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- dap ui setup
    -- for more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- set icons to characters that are more likely to work in every terminal.
      --    feel free to remove or use ones that you like more! :)
      --    don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'dapbreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'dapstop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { breakpoint = '', breakpointcondition = '', breakpointrejected = '', logpoint = '', stopped = '' }
    --   or { breakpoint = '●', breakpointcondition = '⊜', breakpointrejected = '⊘', logpoint = '◆', stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'dap' .. type
    --   local hl = (type == 'stopped') and 'dapstop' or 'dapbreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- install golang specific config
    require('dap-go').setup {
      delve = {
        -- on windows delve must be run attached or it crashes.
        -- see https://github.com/leoluz/nvim-dap-go/blob/main/readme.md#configuring
        detached = true,
      },
      dap_configurations = {
        {
          type = 'go',
          name = 'Go: Launch file',
          request = 'launch',
          program = '${file}', -- Debug the current file
          cwd = '${workspaceFolder}', -- Ensure working directory is the project root
        },
      },
    }
  end,
}
