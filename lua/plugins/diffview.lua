local function get_path_at_cursor()
  local item = require("diffview.lib").get_current_view().panel:get_item_at_cursor()
  if item then
    return item.path
  end
end

local function get_absolute_path_at_cursor()
  local item = require("diffview.lib").get_current_view().panel:get_item_at_cursor()
  if item then
    return item.absolute_path
  end
end

local function get_path_in_preview()
  local item = require("diffview.lib").get_current_view()
  if item then
    return item.cur_entry.path
  end
end

local function get_absolute_path_in_preview()
  local item = require("diffview.lib").get_current_view()
  if item then
    return item.cur_entry.absolute_path
  end
end

local function get_visual_selection_range()
  local start_pos = vim.fn.getpos("v")[2]
  local end_pos = vim.fn.getpos(".")[2]

  -- Go back to normal mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", false, true, true), "nx", false)

  if end_pos < start_pos then
    start_pos, end_pos = end_pos, start_pos
  end
  return start_pos, end_pos
end

local function get_item_from_line_number(line)
  local comp = require("diffview.lib").get_current_view().panel.components.comp:get_comp_on_line(line)
  if comp and comp.name == "file" then
    return comp.context
  elseif comp and comp.name == "dir_name" then
    return comp.parent.context
  end
end

local function get_visual_selection_paths()
  local start_pos, end_pos = get_visual_selection_range()
  local selected_items = {}
  while start_pos <= end_pos do
    local item = get_item_from_line_number(start_pos)
    if item then
      table.insert(selected_items, item.path)
    end
    start_pos = start_pos + 1
  end
  return selected_items
end

return {
  "sindrets/diffview.nvim",
  event = "BufEnter",
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
          { "n", "v" },
          "A",
          function()
            local mode = vim.fn.mode()

            local items
            if mode == "n" then
              items = { get_path_at_cursor() }
            else
              items = get_visual_selection_paths()
            end

            for _, item in ipairs(items) do
              local results = vim.system({ "git", "add", item }, { text = true }):wait()
              if results.code ~= 0 then
                vim.notify(
                  "Add failed with the message: \n" .. vim.trim(results.stdout .. "\n" .. results.stderr),
                  vim.log.levels.ERROR,
                  { title = "Add" }
                )
              end
            end
          end,
          { desc = "Git Add" },
        },
        {
          { "n", "v" },
          "D",
          function()
            local mode = vim.fn.mode()

            local items
            if mode == "n" then
              items = { get_path_at_cursor() }
            else
              items = get_visual_selection_paths()
            end

            for _, item in ipairs(items) do
              local results = vim.system({ "git", "restore", "--staged", item }, { text = true }):wait()
              if results.code ~= 0 then
                vim.notify(
                  "Restore failed with the message: \n" .. vim.trim(results.stdout .. "\n" .. results.stderr),
                  vim.log.levels.ERROR,
                  { title = "Restore" }
                )
              end
            end
          end,
          { desc = "Git Restore" },
        },
      },
    },
  },
}
