return {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup({
      -- ... options, see Configuration section below ...
      -- ... there are no required options atm...
      keymaps = {
        replace = "<leader>rp",
        qflist = "<C-q>",
        gotoLocation = "<enter>",
        close = "<C-x>",
      },
    })
  end,
}
