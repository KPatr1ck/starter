return {
  { "ellisonleao/gruvbox.nvim" },
  { "folke/tokyonight.nvim" },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
    },
  },
  { "shaunsingh/nord.nvim" },
  {
    "rose-pine/neovim",
    as = "rose-pine",
  },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup({
        highlight_overrides = {
          all = function(colors)
            return {
              DiagnosticHint = { fg = colors.teal, style = { "bold" } },
              DiagnosticInfo = { fg = colors.sky, style = { "bold" } },
              DiagnosticWarn = { fg = colors.yellow, style = { "bold" } },
              DiagnosticError = { fg = colors.red, style = { "bold" } },
            }
          end,
        },
      })
    end,
  },
  { "NTBBloodbath/sweetie.nvim" },
  { "ramojus/mellifluous.nvim", dependencies = "rktjmp/lush.nvim" },
  { "JoosepAlviste/palenightfall.nvim" },
  { "Mofiqul/dracula.nvim" },
  { "olimorris/onedarkpro.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "sainnhe/sonokai" },
  { "sainnhe/gruvbox-material" },
  { "sainnhe/everforest" },
  { "sainnhe/edge" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
}
