return {
  {
    "Weissle/persistent-breakpoints.nvim",
    opts = {
      load_breakpoints_event = { "BufReadPost" },
      always_reload = true,
    },
  },
  {
    "mfussenegger/nvim-dap",
    keys = {
      -- 【关键修改】将原有的切换断点改为持久化插件的 API
      {
        "<leader>db",
        function()
          require("persistent-breakpoints.api").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint (Persistent)",
      },
      -- 如果你有条件断点，也建议替换
      {
        "<leader>dB",
        function()
          require("persistent-breakpoints.api").set_conditional_breakpoint()
        end,
        desc = "Conditional Breakpoint (Persistent)",
      },
      -- 一键清除当前项目的所有断点
      {
        "<leader>dD",
        function()
          require("persistent-breakpoints.api").clear_all_breakpoints()
        end,
        desc = "Clear All Breakpoints",
      },
    },
  },
}
