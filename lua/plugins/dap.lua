return {
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