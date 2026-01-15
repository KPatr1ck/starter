return {
  {
    "folke/edgy.nvim",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      left = {
        -- Neo-tree filesystem always takes half the screen height
        {
          title = "Files",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
        },
        {
          title = "Buffers",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "buffers"
          end,
        },
        {
          title = "Git",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "git_status"
          end,
        },
      },

      ---@type table<Edgy.Pos, {size:integer, wo?:vim.wo}>
      options = {
        left = { size = 30 },
        bottom = { size = 10 },
        right = { size = 30 },
        top = { size = 10 },
      },
      -- edgebar animations
      animate = {
        enabled = false,
      },
      -- buffer-local keymaps to be added to edgebar buffers.
      -- Existing buffer-local keymaps will never be overridden.
      -- Set to false to disable a builtin.
      ---@type table<string, fun(win:Edgy.Window)|false>
      keys = {
        -- close window
        ["q"] = function(win)
          win:close()
        end,
        -- increase width
        ["<c-w>>"] = function(win)
          win:resize("width", 2)
        end,
        -- decrease width
        ["<c-w><lt>"] = function(win)
          win:resize("width", -2)
        end,
        -- reset all custom sizing
        ["<c-w>="] = function(win)
          win.view.edgebar:equalize()
        end,
        -- hide window
        ["<c-q>"] = function(win)
          win:hide()
        end,
        -- close sidebar
        ["Q"] = function(win)
          win.view.edgebar:close()
        end,
        -- next open window
        ["]w"] = function(win)
          win:next({ visible = true, focus = true })
        end,
        -- previous open window
        ["[w"] = function(win)
          win:prev({ visible = true, focus = true })
        end,
        -- next loaded window
        ["]W"] = function(win)
          win:next({ pinned = false, focus = true })
        end,
        -- prev loaded window
        ["[W"] = function(win)
          win:prev({ pinned = false, focus = true })
        end,
      },
      icons = {
        closed = "⮚",
        open = "⮛",
      },
      -- enable this on Neovim <= 0.10.0 to properly fold edgebar windows.
      -- Not needed on a nightly build >= June 5, 2023.
      fix_win_height = vim.fn.has("nvim-0.10.0") == 0,
    },
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function()
      local Offset = require("bufferline.offset")
      Offset.get = function()
        return {
          left = "",
          left_size = 0,
          right = "",
          right_size = 0,
          total_size = 0,
        }
      end
    end,
  },
}
