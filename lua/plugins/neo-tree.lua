local keymaps = {
  ["<space>"] = {
    "toggle_node",
    nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
  },
  ["o"] = "open",
  ["<cr>"] = "open_drop",
  ["<esc>"] = "revert_preview",
  ["<Tab>"] = { "toggle_preview", config = { use_float = true } },
  ["<leader>w"] = "open_split",
  ["<leader>wv"] = "open_vsplit",
  ["t"] = "open_tabnew",
  ["H"] = "noop",
  ["z"] = "close_node",
  ["-"] = "close_all_nodes",
  ["+"] = "expand_all_nodes",
  ["."] = "toggle_hidden",
  ["a"] = {
    "add",
    -- some commands may take optional config options, see `:h neo-tree-mappings` for details
    config = {
      show_path = "none", -- "none", "relative", "absolute"
    },
  },
  ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
  ["dd"] = "delete",
  ["r"] = "rename",
  ["y"] = "copy_to_clipboard",
  ["x"] = "cut_to_clipboard",
  ["p"] = "paste_from_clipboard",
  ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
  -- ["c"] = {
  --  "copy",
  --  config = {
  --    show_path = "none" -- "none", "relative", "absolute"
  --  }
  --}
  ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
  ["q"] = "close_window",
  ["R"] = "refresh",
  ["?"] = "show_help",
  ["<"] = "prev_source",
  [">"] = "next_source",
  ["<c-f>"] = "noop",
  ["<c-b>"] = "noop",
  ["<c-u>"] = { "scroll_preview", config = { direction = 10 } },
  ["<c-d>"] = { "scroll_preview", config = { direction = -10 } },
}

return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "tr", "<cmd>Neotree reveal action=focus toggle=true<cr>", desc = "Toggle Neotree" },
    { "ts", "<cmd>Neotree reveal action=show<cr>", desc = "Open Neotree" },
    { "tf", "<cmd>Neotree reveal action=focus<cr>", desc = "Focus Neotree" },
    { "tb", "<cmd>Neotree reveal action=focus source=buffers<cr>" },
    { "tc", "<cmd>Neotree action=close<cr>", desc = "Close Neotree" },
  },
  opts = {
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = true, -- used when sorting files and directories in the tree
    sort_function = nil, -- use a custom function for sorting files and directories in the tree
    window = {
      position = "left",
      width = "25%",
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = keymaps,
    },
    nesting_rules = {},
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_by_pattern = { -- uses glob style patterns
          "*.png",
          "*.jpg",
        },
      },
      follow_current_file = {
        enabled = true,
      },
      hijack_netrw_behavior = "disabled",
      commands = {
        copy_filename = function(state)
          local node = state.tree:get_node()
          print(string.format("Copy %s to clipboard.", node.name))
          vim.fn.setreg("*", node.name, "c")
        end,
        copy_abs_path = function(state)
          local node = state.tree:get_node()
          local full_path = node.path
          print(full_path)
          print(string.format("Copy %s to clipboard.", full_path))
          vim.fn.setreg("*", full_path, "c")
        end,
        copy_path = function(state)
          local node = state.tree:get_node()
          local full_path = node.path
          local relative_path = full_path:sub(#state.path + 2)
          print(relative_path)
          print(string.format("Copy %s to clipboard.", relative_path))
          vim.fn.setreg("*", relative_path, "c")
        end,
      },
      window = {
        mappings = {
          ["P"] = "navigate_up",
          ["cd"] = "set_root",
          ["."] = "toggle_hidden",
          ["cf"] = "copy_filename",
          ["ca"] = "copy_abs_path",
          ["cp"] = "copy_path",
        },
      },
    },
    buffers = {
      follow_current_file = {
        enabled = true,
      },
      -- time the current file is changed while the tree is open.
      group_empty_dirs = true, -- when true, empty folders will be grouped together
      show_unloaded = true,
      window = {
        mappings = {
          ["."] = "noop",
          ["bd"] = "buffer_delete",
        },
      },
    },
    git_status = {
      commands = {
        show_diff = function(state)
          local node = state.tree:get_node()
          local is_file = node.type == "file"
          if not is_file then
            vim.notify("Diff only for files", vim.log.levels.ERROR)
            return
          end
          local cc = require("neo-tree.sources.common.commands")
          cc.open(state, function()
            -- do nothing for dirs
          end)

          -- diffview.nvim
          vim.cmd([[DiffviewOpen -- %]])
        end,
      },
      window = {
        mappings = {
          ["."] = "noop",
          ["gA"] = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
          ["D"] = "show_diff",
        },
      },
    },
  },
}
