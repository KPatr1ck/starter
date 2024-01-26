local function get_path_at_cursor()
  return require("diffview.lib").get_current_view().panel:get_item_at_cursor().path
end

local function get_absolute_path_at_cursor()
  return require("diffview.lib").get_current_view().panel:get_item_at_cursor().absolute_path
end

local function get_path_in_preview()
  return require("diffview.lib").get_current_view().cur_entry.path
end

local function get_absolute_path_in_preview()
  return require("diffview.lib").get_current_view().cur_entry.absolute_path
end

return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "TimUntersberger/neogit", opts = { disable_commit_confirmation = true } },
  },
  keys = {
    { "<C-g>", "<CMD>DiffviewOpen<CR>", mode = { "n", "i", "v" }, desc = "DiffviewOpen" },
  },
  opts = {
    keymaps = {
      view = {
        { "n", "<C-g>", "<CMD>DiffviewClose<CR>", { desc = "DiffviewClose" } },
      },
      file_panel = {
        { "n", "<C-g>", "<CMD>DiffviewClose<CR>", { desc = "DiffviewClose" } },
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
          { desc = "Git Commit" },
        },
        {
          "n",
          "A",
          function()
            local results = vim.system({ "git", "add", get_path_at_cursor() }, { text = true }):wait()
            if results.code ~= 0 then
              vim.notify(
                "Add failed with the message: \n" .. vim.trim(results.stdout .. "\n" .. results.stderr),
                vim.log.levels.ERROR,
                { title = "Add" }
              )
            end
          end,
          { desc = "Git Add" },
        },
        {
          "n",
          "D",
          function()
            local results = vim.system({ "git", "restore", "--staged", get_path_at_cursor() }, { text = true }):wait()
            if results.code ~= 0 then
              vim.notify(
                "Restore failed with the message: \n" .. vim.trim(results.stdout .. "\n" .. results.stderr),
                vim.log.levels.ERROR,
                { title = "Restore" }
              )
            end
          end,
          { desc = "Git Restore" },
        },
      },
    },
  },
}
