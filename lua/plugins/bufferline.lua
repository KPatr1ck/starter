return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "moll/vim-bbye" },
  keys = {
    { "<S-Tab>", "<C-^>" },
    { "<C-PageUp>", "<cmd>BufferLineCyclePrev<cr>" },
    { "<C-PageDown>", "<cmd>BufferLineCycleNext<cr>" },
    { "<C-A-h>", "<cmd>BufferLineMovePrev<cr>" },
    { "<C-A-l>", "<cmd>BufferLineMoveNext<cr>" },
    { "<leader>c", "<cmd>bp <BAR> bd #<cr>", desc = "Close buffer" },
    { "<leader>cr", "<cmd>BufferLineCloseRight<cr>", desc = "Close buffers on rhs" },
    { "<leader>cl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close buffers on lhs" },
    -- { "<leader>p", "<cmd>BufferLinePick<cr>", desc = "Pick buffer from tag" },
    { "<leader>pc", "<cmd>BufferLinePickClose<cr>", desc = "Close buffer from tag" },
  },
  opts = {
    options = {
      -- separator_style = 'slant',
      close_command = "Bdelete! %d",
      right_mouse_command = "Bdelete! %d",
      diagnostics = "nvim_lsp",
      numbers = function(opts)
        return string.format("%s|%s", opts.ordinal, opts.raise(opts.id))
      end,
      sort_by = "insert_after_current",
      show_buffer_close_icons = false,
      always_show_bufferline = true,
    },
    highlights = {
      buffer_selected = {
        bold = true,
        italic = true,
      },
      indicator_selected = {
        fg = "#00BFFF",
      },
    },
  },
}
