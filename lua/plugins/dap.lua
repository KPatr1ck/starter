return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "linux-cultist/venv-selector.nvim",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      {
        "<leader>dR",
        function()
          require("dap").restart()
        end,
        desc = "Restart",
      },
      -- 我们自定义的快速 Attach 命令
      {
        "<leader>dA",
        function()
          vim.ui.input({ prompt = "Attach Port: ", default = "5678" }, function(input)
            local port = tonumber(input)
            if not port then
              vim.notify("Error: Invalid port number", vim.log.levels.ERROR)
              return
            end

            local dap = require("dap")
            -- 动态定义一个针对该端口的适配器
            dap.adapters.pydirect = {
              type = "server",
              host = "127.0.0.1",
              port = port,
            }

            -- 运行配置
            dap.run({
              name = "Direct Attach (Port " .. port .. ")",
              type = "pydirect",
              request = "attach",
              pathMappings = {
                {
                  localRoot = vim.fn.getcwd(),
                  remoteRoot = vim.fn.getcwd(),
                },
              },
            })
          end)
        end,
        desc = "Attach to Python Process (Interactive Port)",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      -- 设置 dapui
      dapui.setup(opts)

      -- 自动打开/关闭 DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        require("neo-tree.command").execute({ action = "close" })
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python", -- 仅在 Python 文件中加载
    config = function()
      local dap = require("dap")

      local function get_python_path()
        local success, vs = pcall(require, "venv-selector")
        if success then
          local path = vs.python()
          if path and path ~= "" then
            return path
          end
        end
        return vim.fn.exepath("python3") or "python3"
      end

      local path = get_python_path()
      require("dap-python").setup(path)

      if dap.configurations.python then
        for _, config in ipairs(dap.configurations.python) do
          config.pythonPath = get_python_path
        end
      end
    end,
  },
}
