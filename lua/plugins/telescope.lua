return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- Custom keymaps
    { "<C-Insert>", "<cmd>Telescope find_files<cr>", desc = "Telescope find_files" },
    { "<C-Del>", "<cmd>Telescope buffers sort_mru=true<cr>", desc = "Telescope buffers" },
    { "<C-A-f>", "<cmd>Telescope live_grep<cr>", desc = "Telescope live_grep" },
    -- disable the keymap to grep files
    { "<leader>/", false },
    -- change a keymap
    { "<leader>lg", "<cmd>Telescope live_grep<cr>", desc = "Telescope live_grep" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    -- add a keymap to browse plugin files
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
  },
  opts = {

    defaults = {
      initial_mode = "insert",
      mappings = {
        i = {
          ["<Down>"] = "move_selection_next",
          ["<Up>"] = "move_selection_previous",
          ["<C-j>"] = "cycle_history_next",
          ["<C-k>"] = "cycle_history_prev",
          ["<C-c>"] = "close",
          ["<C-u>"] = "preview_scrolling_up",
          ["<C-d>"] = "preview_scrolling_down",
        },
      },
    },
    pickers = {
      colorscheme = {
        enable_preview = true,
      },
    },
    extensions = {},
  },
}
