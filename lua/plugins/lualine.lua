local Util = require("lazyvim.util")

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local signs = { Error = " ", Warn = " ", Hint = "󰍨 ", Info = " " }

    local function get_searchcount()
      local msg = require("noice").api.status.search.get()
      local sinfo = vim.fn.searchcount({ maxcount = 0 })
      msg = msg:gsub("%[>?%d+/>?%d+%]", "") .. ("[%s/%s]"):format(sinfo.current, sinfo.total)
      return msg
    end

    require("lualine").setup({
      options = {
        theme = auto,
        -- https://github.com/ryanoasis/powerline-extra-symbols
        -- component_separators = { left = ' ', right = ' ' },
        -- section_separators = { left = '', right = '' },

        -- component_separators = { left = '|', right = '|' },
        -- section_separators = { left = '', right = '' },

        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { -- Filetypes to disable lualine for.
          statusline = {}, -- only ignores the ft for statusline.
          winbar = {}, -- only ignores the ft for winbar.
        },
      },
      sections = {
        lualine_a = {
          -- {
          --   require("noice").api.status.mode.get,
          --   cond = require("noice").api.status.mode.has,
          --   -- color = { bg = "#ff9e64", fg = "#ffffff" },
          --   padding = 2,
          -- },
          { "mode", padding = 2 },
        },
        lualine_b = {
          { "branch", padding = 2 },
          { "diff", padding = 2 },
          {
            "diagnostics",
            -- Table of diagnostic sources, available sources are:
            --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
            -- or a function that returns a table as such:
            --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
            sources = { "nvim_diagnostic", "coc" },

            -- Displays diagnostics for the defined severity types
            sections = { "error", "warn", "info", "hint" },
            symbols = { error = signs.Error, warn = signs.Warn, info = signs.Info, hint = signs.Hint },
            colored = true, -- Displays diagnostics status in color if set to true.
            update_in_insert = false, -- Update diagnostics in insert mode.
            always_visible = false, -- Show diagnostics even if there are none.
            padding = 2,
          },
        },
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          -- { "filename", padding = 1 },
          { Util.lualine.pretty_path() },
          {
            "lsp_progress",
            -- spinner_symbols = { ' ', ' ', ' ', ' ', ' ', ' ' },
          },
        },
        lualine_x = {
          -- 'filesize',
          -- {
          --     'fileformat',
          --     -- symbols = {
          --     --   unix = '', -- e712
          --     --   dos = '', -- e70f
          --     --   mac = '', -- e711
          --     -- },
          --     symbols = {
          --         unix = 'LF',
          --         dos = 'CRLF',
          --         mac = 'CR',
          --     },
          -- },
          -- 'encoding',
          -- "filetype",
          -- stylua: ignore
          {
            "aerial",
            -- The number of symbols to render top-down. In order to render only 'N' last
            -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
            -- be used in order to render only current symbol.
            depth = 5,
            -- When 'dense' mode is on, icons are not rendered near their symbols. Only
            -- a single icon that represents the kind of current symbol is rendered at
            -- the beginning of status line.
            dense = true,
            -- The separator to be used to separate symbols in dense mode.
            dense_sep = " > ",
            -- Color the symbol icons.
            colored = true,
          },
          -- {
          --   require("trouble").statusline({
          --     mode = "symbols",
          --     groups = {},
          --     title = false,
          --     filter = { range = true },
          --     format = "{kind_icon}{symbol.name:Normal}",
          --   }).get,
          --   cond = require("trouble").statusline({ mode = "symbols" }).has,
          -- },
          {
            function()
              return require("noice").api.status.command.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.command.has()
            end,
            color = Util.ui.fg("Statement"),
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = Util.ui.fg("Constant"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = Util.ui.fg("Debug"),
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = Util.ui.fg("Special"),
          },
        },
        lualine_y = {

          { "progress", padding = 2 },
          {
            -- require("noice").api.status.search.get,
            get_searchcount,
            cond = require("noice").api.status.search.has,
          },
        },
        lualine_z = { { "location", padding = 2 } },
      },
      extensions = { "neo-tree", "lazy", "nvim-tree", "toggleterm" },
    })
  end,
}
