return {
  settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = 'openFilesOnly',
        typeCheckingMode = 'standard',
        useLibraryCodeForTypes = true,
        autoSearchPaths = true,
        enableReachabilityAnalysis = false,
        inlayHints = {
          callArgumentNames = true,
        },
        extraPaths = {},
      },
      pythonPath = vim.fn.getcwd() .. '/.venv/bin/python',
    },
  },
}
