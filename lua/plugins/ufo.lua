return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  config = function()
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.foldcolumn = "1" -- '0' is not bad

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set("n", "<leader>z", "za")
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)

    local exclude_filetypes =
      { ["noice"] = "", ["neo-tree"] = "", ["aerial"] = "", ["trouble"] = "", ["floaterm"] = "" }
    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        if exclude_filetypes[filetype] then
          return exclude_filetypes[filetype]
        else
          return { "treesitter", "indent" }
        end
      end,
    })
  end,
}
