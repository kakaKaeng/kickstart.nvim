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
    'igorlfs/nvim-dap-view',

    -- Required dependency for nvim-dap-ui
    -- 'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',

    'theHamsta/nvim-dap-virtual-text',
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
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dap-view').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    -- local dapui = require 'dapui'
    local daview = require 'dap-view'
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
        'debugpy',
      },
    }

    -- change breakpoint icons
    vim.fn.sign_define('DapBreakpoint', { text = '🤔' })

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

    require('dap-python').setup 'uv'
    dap.configurations = {
      python = {
        {
          -- The first three options are required by nvim-dap
          type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
          request = 'launch',
          name = 'Launch file',

          -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

          program = '${file}', -- This configuration will launch the current file if used.
          pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
              return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
              return cwd .. '/.venv/bin/python'
            else
              return '/usr/bin/python'
            end
          end,
        },

        {
          type = 'python',
          request = 'launch',
          name = 'Launch FastAPI with uv (.env included)',
          module = 'uvicorn',
          args = {
            'app.main:app',
            '--port',
            '8000',
            '--reload',
            '--env-file=.env',
          },
          cmd = '${workspaceFolder}',
        },
      },
    }
  end,
}
