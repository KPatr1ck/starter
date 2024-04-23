return {
  {
    "stevearc/aerial.nvim",
    keys = {
      { "<leader>a", "<cmd>AerialToggle!<cr>", mode = { "n" }, desc = "Aerial Toggle" },
    },
  },
  {
    "RRethy/vim-illuminate",
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
      filetypes_denylist = {
        "dirbuf",
        "dirvish",
        "fugitive",
        "neo-tree",
        "aerial",
        "noice",
      },
    },
  },
}
