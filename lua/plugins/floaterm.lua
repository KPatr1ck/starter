-- Terminal ui config
vim.g.floaterm_wintype = "float"
vim.g.floaterm_position = "bottomright"
vim.g.floaterm_autoinsert = true
vim.g.floaterm_title = "TERM($1/$2)"
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8

return {
  "voldikss/vim-floaterm",
  init = function()
    require("lazy").load({ plugins = { "vim-floaterm" } })
  end,
  keys = {
    { "<leader>t", "<cmd>FloatermNew<cr>", desc = "Open new Floaterm" },
    { "<leader>t", "<C-\\><C-n><cmd>FloatermNew<cr>", mode = { "t" }, desc = "Open new Floaterm" },
    { "<C-PageUp>", "<cmd>FloatermPrev<cr>", desc = "Floaterm cycle prev" },
    { "<C-PageUp>", "<C-\\><C-n><cmd>FloatermPrev<cr>", mode = { "t" }, desc = "Floaterm cycle prev" },
    { "<C-PageDown>", "<cmd>FloatermNext<cr>", desc = "Floaterm cycle next" },
    { "<C-PageDown>", "<C-\\><C-n><cmd>FloatermNext<cr>", mode = { "t" }, desc = "Floaterm cycle next" },
    { "<C-N>", "<cmd>FloatermToggle<cr>", desc = "Floaterm toggle" },
    { "<C-N>", "<C-\\><C-n><cmd>FloatermToggle<cr>", mode = { "t" }, desc = "Floaterm toggle" },
    { "<C-.>", "<cmd>FloatermToggle<cr>", desc = "Floaterm toggle" },
    { "<C-.>", "<C-\\><C-n><cmd>FloatermToggle<cr>", mode = { "t" }, desc = "Floaterm toggle" },
  },
}
