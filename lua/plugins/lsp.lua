return {
  -- Configure LSP servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Configure basedpyright with less strict type checking
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
                -- 关闭过于严格的类型检查
                typeCheckingMode = "basic", -- 可选: "off", "basic", "standard", "strict"
                diagnosticSeverityOverrides = {
                  reportMissingTypeStubs = "none", -- 关闭缺失类型存根警告
                  reportUnknownMemberType = "none", -- 关闭未知成员类型警告
                  reportUnknownParameterType = "none", -- 关闭未知参数类型警告
                  -- reportUnknownVariableType = "none", -- 关闭未知变量类型警告
                  -- reportUnknownArgumentType = "none", -- 关闭未知参数类型警告
                  -- reportUnknownLambdaType = "none", -- 关闭未知 lambda 类型警告
                  -- reportImportCycles = "none", -- 关闭循环导入警告
                  -- reportPrivateUsage = "none", -- 关闭私有成员使用警告
                },
              },
            },
          },
        },
        -- Configure ruff
        ruff = {},
        -- Configure lua_ls to recognize Neovim runtime
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim" }, -- Recognize 'vim' as a global variable
              },
              workspace = {
                library = {
                  vim.env.VIMRUNTIME,
                  -- Add other paths if needed
                  -- "${3rd}/luv/library",
                  -- "${3rd}/busted/library",
                },
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
}
