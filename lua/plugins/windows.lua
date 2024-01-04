return {
  "anuvyklack/windows.nvim",
  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },
  config = function()
    vim.o.winwidth = 10
    vim.o.winminwidth = 10
    vim.o.equalalways = false
    require("windows").setup()
  end,
  keys = {
    { "<C-w>z", "<cmd>WindowsMaximize<cr>" },
    { "<C-w>_", "<cmd>WindowsMaximizeVertically<cr>" },
    { "<C-w>|", "<cmd>WindowsMaximizeHorizontally<cr>" },
    { "<C-w>=", "<cmd>WindowsEqualize<cr>" },
  },
  event = "VeryLazy",
}
