return {
  "chrisgrieser/nvim-scissors",
  dependencies = "nvim-telescope/telescope.nvim", -- optional
  keys = {
    {
      "<leader>se",
      function()
        require("scissors").editSnippet()
      end,
      mode = { "n" },
      desc = "Edit Snippet",
    },
    -- When used in visual mode prefills the selection as body.
    {
      "<leader>sa",
      function()
        require("scissors").addNewSnippet()
      end,
      mode = { "n", "x" },
      desc = "Add Snippet",
    },
  },
  opts = {
    jsonFormatter = "jq", -- "yq"|"jq"|"none"
  },
}
