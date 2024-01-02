return {
  "nvimdev/lspsaga.nvim",
  keys = {
    -- rename
    { "<leader>rn", "<cmd>Lspsaga rename<cr>", mode = { "n" }, desc = "Lspsaga Rename" },
    -- code action
    -- { "<leader>ca", "<cmd>Lspsaga code_action<cr>", mode = { "n" }, desc = "Lspsaga Code Action" },
    -- navi
    { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", mode = { "n" }, desc = "Go Definition" },
    { "gh", "<cmd>Lspsaga hover_doc<cr>", mode = { "n" }, desc = "Lspsaga Hover Doc" },
    { "gr", "<cmd>Lspsaga lsp_finder<cr>", mode = { "n" }, desc = "Lspsaga References" },
    -- diagnostic
    { "gp", "<cmd>Lspsaga show_line_diagnostics<cr>", mode = { "n" }, desc = "Show Line Diagnostics" },
    { "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", mode = { "n" }, desc = "Diagnostic Jump Next" },
    { "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", mode = { "n" }, desc = "Diagnostic Jump Prev" },
  },
  config = function()
    require("lspsaga").setup({
      ui = {
        theme = "round",
        title = true,
        winblend = 0,
        border = "rounded",
      },
      preview = {
        lines_above = 0,
        lines_below = 10,
      },
      scroll_preview = {
        scroll_down = "<C-f>",
        scroll_up = "<C-b>",
      },
      request_timeout = 2000,
      finder = {
        --percentage
        max_height = 0.5,
        keys = {
          jump_to = "p",
          edit = { "o", "<CR>" },
          vsplit = "s",
          split = "i",
          tabe = "t",
          tabnew = "r",
          quit = { "q", "<ESC>" },
          close_in_preview = "<ESC>",
        },
      },
      definition = {
        edit = "<C-c>o",
        vsplit = "<C-c>v",
        split = "<C-c>i",
        tabe = "<C-c>t",
        quit = "q",
      },
      code_action = {
        num_shortcut = true,
        show_server_name = false,
        extend_gitsigns = true,
        keys = {
          -- string | table type
          quit = "q",
          exec = "<CR>",
        },
      },
      lightbulb = {
        enable = false,
        enable_in_insert = false,
        sign = true,
        sign_priority = 40,
        virtual_text = true,
      },
      diagnostic = {
        on_insert = false,
        on_insert_follow = false,
        insert_winblend = 0,
        show_code_action = true,
        show_source = true,
        jump_num_shortcut = true,
        --1 is max
        max_width = 0.7,
        custom_fix = nil,
        custom_msg = nil,
        text_hl_follow = false,
        border_follow = true,
        keys = {
          exec_action = "o",
          quit = "q",
          go_action = "g",
        },
      },
      rename = {
        quit = "<C-c>",
        exec = "<CR>",
        mark = "x",
        confirm = "<CR>",
        in_select = true,
      },
      outline = {
        win_position = "right",
        win_with = "",
        win_width = 30,
        show_detail = true,
        auto_preview = true,
        auto_refresh = true,
        auto_close = true,
        custom_sort = nil,
        keys = {
          jump = "o",
          expand_collapse = "u",
          quit = "q",
        },
      },
      callhierarchy = {
        show_detail = false,
        keys = {
          edit = "e",
          vsplit = "s",
          split = "i",
          tabe = "t",
          jump = "o",
          quit = "q",
          expand_collapse = "u",
        },
      },
      symbol_in_winbar = {
        enable = false,
        separator = " >> ",
        ignore_patterns = { "noice" },
        show_file = false,
        folder_level = 2,
        color_mode = true,
      },
    })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
}
