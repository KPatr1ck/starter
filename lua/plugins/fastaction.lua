return {
  "Chaitanyabsprip/fastaction.nvim",
  ---@type FastActionConfig
  opts = {},
  keys = {
    {
      "<leader>ca",
      '<cmd>lua require("fastaction").code_action()<CR>',
      mode = { "n" },
      desc = "[Fastaction] Code Action.",
    },
  },
}
