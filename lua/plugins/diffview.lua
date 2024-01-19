return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "TimUntersberger/neogit", opts = { disable_commit_confirmation = true } },
  },
  keys = {
    { "<C-g>", "<CMD>DiffviewOpen<CR>", mode = { "n", "i", "v" } },
  },
  opts = {
    keymaps = {
      view = {

        { "n", "<C-g>", "<CMD>DiffviewClose<CR>" },
      },
      file_panel = {
        {
          "n",
          "cc",
          function()
            vim.ui.input({ prompt = "Commit message: " }, function(msg)
              if not msg then
                return
              end
              local results = vim.system({ "git", "commit", "-m", msg }, { text = true }):wait()

              if results.code ~= 0 then
                vim.notify(
                  "Commit failed with the message: \n" .. vim.trim(results.stdout .. "\n" .. results.stderr),
                  vim.log.levels.ERROR,
                  { title = "Commit" }
                )
              else
                vim.notify(results.stdout, vim.log.levels.INFO, { title = "Commit" })
              end
            end)
          end,
        },
      },
    },
  },
}
