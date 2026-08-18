
local capabilities = require('blink.cmp').get_lsp_capabilities()
local lspconfig = require 'lspconfig'
-- lspconfig['ts_ls'].setup { capabilities = capabilities }
-- vim.lsp.config['ts_ls'].capabilities = capabilities

-- local util = require 'lspconfig.util'
-- local workspace_root = util.root_pattern('nx.json', 'package.json', 'tsconfig.base.json', '.git')(filename)
-- vim.lsp.config['ts_ls'].root_dir = function(filename, bufnr)
--   -- Look for global workspace markers first to force the monorepo root
--   local workspace_root = util.root_pattern('nx.json', 'package.json', 'tsconfig.base.json', '.git')(filename)
--
--   -- Fallback to the default buffer directory if no root markers are found
--   return workspace_root or util.path.dirname(filename)
-- end
return {

  -- root_dir = function(bufnr, on_dir)
  --   local util = require 'lspconfig.util'
  --   return util.root_pattern('tsconfig.base.json', 'package.json', '.git')(vim.api.nvim_buf_get_name(bufnr))
  -- end,
  capabilities = capabilities,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}
