-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

------------------------------------------------------- PersistedHooks
local persisted_group = vim.api.nvim_create_augroup("PersistedHooks", {})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "PersistedSavePre",
  group = persisted_group,
  callback = function()
    require("neo-tree.command").execute({ action = "close" })
  end,
})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "PersistedTelescopeLoadPre",
  group = persisted_group,
  callback = function()
    if vim.g.persisted_loaded_session then
      -- Save the currently loaded session using a global variable
      require("persisted").save({ session = vim.g.persisted_loaded_session })
      -- Delete all of the open buffers
      vim.cmd(":%bd!")
    end

    -- Don't start saving the session yet
    require("persisted").stop()
  end,
})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "PersistedTelescopeLoadPost",
  group = persisted_group,
  callback = function()
    require("persisted").start()
  end,
})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "PersistedLoadPost",
  group = persisted_group,
  callback = function()
    require("neo-tree.command").execute({ action = "show", dir = vim.loop.cwd() })
    -- FIXME: Used to clear line no shown in neo-tree (Just don't konw why...)
    require("neo-tree.command").execute({ action = "close" })
  end,
})

------------------------------------------------------- Mini Starter
local mini_group = vim.api.nvim_create_augroup("Mini Starter", {})

vim.api.nvim_create_autocmd({ "user" }, {
  group = mini_group,
  callback = function()
    if vim.bo.filetype == "starter" then
      vim.o.showtabline = 0
    end
  end,
})
