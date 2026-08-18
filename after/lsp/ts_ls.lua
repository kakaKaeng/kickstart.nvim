---@type vim.lsp.Config
return {
  -- init_options = {
  --   hostInfo = 'neovim',
  --
  --   preferences = {
  --     includeCompletionsForModuleExports = true,
  --     includeCompletionsForImportStatements = true,
  --     importModuleSpecifierPreference = 'shortest',
  --     includePackageJsonAutoImports = 'on',
  --   },
  -- },

  settings = {
    ['js/ts'] = {
      implementationsCodeLens = {
        enabled = true,
        showOnAllClassMethods = true,
        showOnInterfaceMethods = true,
      },

      referencesCodeLens = {
        enabled = true,
        showOnAllFunctions = true,
      },

      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = {
          enabled = 'literals',
          suppressWhenArgumentMatchesName = true,
        },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = true },
      },
    },
  },
}
