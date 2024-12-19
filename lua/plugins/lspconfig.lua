return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              diagnosticSeverityOverrides = {
                reportUnusedImport = false,
              },
              typeCheckingMode = "standard",
            },
          },
        },
      },
    },
  },
}
