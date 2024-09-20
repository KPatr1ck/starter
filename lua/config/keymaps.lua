-- Default LazyVim keymaps can be deleted with vim.keymap.del
vim.keymap.del("n", "H")
vim.keymap.del("n", "L")
vim.keymap.del({ "n", "v" }, "s")
vim.keymap.del({ "n", "v" }, "S")
vim.keymap.del({ "t" }, "<C-h>")
vim.keymap.del({ "t" }, "<C-j>")
vim.keymap.del({ "t" }, "<C-k>")
vim.keymap.del({ "t" }, "<C-l>")

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

------------------------------------------------ Keybindings for Common Nvim

-- Silent undo and redo
map("n", "u", ":silent undo<CR>", opt)
map("n", "<C-r>", ":silent redo<CR>", opt)

-- 在visual 模式里粘贴不要复制
map("v", "p", '"_dP', opt)

-- insert 模式下，跳到行首行尾
map("i", "<C-a>", "<ESC>I", opt)
map("i", "<C-e>", "<ESC>A", opt)

-- windows
map("n", "<leader>wv", ":vsp<CR>", { noremap = true, silent = true, desc = "[Window] Split vertically." })
map("n", "<leader>w", ":sp<CR>", { noremap = true, silent = true, desc = "[Window] Split horizontally." })
-- 关闭当前
map("n", "<leader>wc", "<C-w>c", { noremap = true, silent = true, desc = "[Window] Close current window." })
-- 关闭其他
map("n", "<leader>wo", "<C-w>o", { noremap = true, silent = true, desc = "[Window] Close other windows." })
-- 窗口移动
map("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "[Window] Move up." })
map("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "[Window] Move down." })
map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "[Window] Move left." })
map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "[Window] Move right." })

-- 复制文件路径信息
-- relative path  (src/foo.txt)
map("n", "<leader>cp", ':let @+=expand("%")<CR>', { noremap = true, silent = true, desc = "[Path] Copy rel path." })
-- absolute path  (/something/src/foo.txt)
map("n", "<leader>cP", ':let @+=expand("%:p")<CR>', { noremap = true, silent = true, desc = "[Path] Copy abs path." })
-- filename       (foo.txt)
map("n", "<leader>cf", ':let @+=expand("%:t")<CR>', { noremap = true, silent = true, desc = "[Path] Copy filename." })

-- Code fold
map("n", "_", ":foldclose<CR>", opt)
map("n", "+", ":foldopen<CR>", opt)

-- Save
map("n", "<leader>bw", ":w<CR>", { noremap = true, silent = true, desc = "[Buffer] Save." })
map("n", "<leader>bn", ":noautocmd w<CR>", { noremap = true, silent = true, desc = "[Buffer] Save without autocmd." })

------------------------------------------------ Keybindings for Custom Plugins

-- Trouble
map("n", "<leader>td", ":TodoTrouble<CR>", { noremap = true, silent = true, desc = "[Trouble] Open TodoTrouble." })

-- Gitsigns
map(
  "n",
  "<leader>g>",
  ":Gitsigns next_hunk<CR>",
  { noremap = true, silent = true, desc = "[Gitsigns] Jump to next diff hunk." }
)
map(
  "n",
  "<leader>g<",
  ":Gitsigns prev_hunk<CR>",
  { noremap = true, silent = true, desc = "[Gitsigns] Jump to prev diff hunk." }
)
map(
  "n",
  "<leader>grh",
  ":Gitsigns reset_hunk<CR>",
  { noremap = true, silent = true, desc = "[Gitsigns] Restore hunk." }
)
map(
  "n",
  "<leader>grb",
  ":Gitsigns reset_buffer<CR>",
  { noremap = true, silent = true, desc = "[Gitsigns] Restore buffer." }
)

-- Terminal
map("t", "<C-Home>", "<C-\\><C-n>", opt)

-- Comment
local api = require("Comment.api")
local key = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
vim.keymap.set("n", "<C-_>", api.toggle.linewise.current, opt)
vim.keymap.set("n", "<C-/>", api.toggle.linewise.current, opt)
vim.keymap.set("n", "<C-\\>", api.toggle.blockwise.current, opt)
vim.keymap.set("v", "<C-_>", function()
  vim.api.nvim_feedkeys(key, "nx", false)
  api.locked("toggle.linewise")(vim.fn.visualmode())
end)
vim.keymap.set("v", "<C-/>", function()
  vim.api.nvim_feedkeys(key, "nx", false)
  api.locked("toggle.linewise")(vim.fn.visualmode())
end)
vim.keymap.set("v", "<C-\\>", function()
  vim.api.nvim_feedkeys(key, "nx", false)
  api.locked("toggle.blockwise")(vim.fn.visualmode())
end)
vim.keymap.set("v", "<C-p>", function()
  local win = vim.api.nvim_get_current_win()
  local cur = vim.api.nvim_win_get_cursor(win)
  local vstart = vim.fn.getpos("v")[2]
  local current_line = vim.fn.line(".")
  local set_cur = vim.api.nvim_win_set_cursor

  if vstart == current_line then
    vim.cmd.yank()
    api.toggle.linewise.current()
    vim.cmd.put()
    set_cur(win, { cur[1] + 1, cur[2] })
  else
    if vstart < current_line then
      vim.cmd(":" .. vstart .. "," .. current_line .. "y")
      vim.cmd.put()
      set_cur(win, { vim.fn.line("."), cur[2] })
    else
      vim.cmd(":" .. current_line .. "," .. vstart .. "y")
      set_cur(win, { vstart, cur[2] })
      vim.cmd.put()
      set_cur(win, { vim.fn.line("."), cur[2] })
    end
    api.toggle.linewise(vim.fn.visualmode())
  end
end, { noremap = true, silent = true })

-- LSP
map("n", "<leader>rn", "<leader>cr", { noremap = false, desc = "Rename" })
