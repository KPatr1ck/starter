return {
  -- 1. 配置 nvim-dap
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    -- 这里的 keys 会合并到 LazyVim 默认的快捷键中
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

  -- 2. 配置 nvim-dap-ui (作为独立项或集成在上面)
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

      -- 鼠标模式切换（使用独立的监听器名称避免冲突）
      dap.listeners.before.attach.dapui_mouse = function()
        vim.o.mouse = "a"
      end
      dap.listeners.before.launch.dapui_mouse = function()
        vim.o.mouse = "a"
      end
      dap.listeners.before.event_terminated.dapui_mouse = function()
        vim.o.mouse = ""
      end
      dap.listeners.before.event_exited.dapui_mouse = function()
        vim.o.mouse = ""
      end
    end,
  },
}
