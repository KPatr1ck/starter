return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "yapf", "autopep8", "isort", "black" },
      json = { "jq" },
      -- Use a sub-list to run only the first available formatter
      javascript = { { "prettierd", "prettier" } },
    },
  },
}
