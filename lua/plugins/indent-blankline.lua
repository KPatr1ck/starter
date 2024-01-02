local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#a54e56" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#d9b263" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#0b5394" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#b46950" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#8aa872" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#a96ca5" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#69a7ba" })
end)

return {
  "lukas-reineke/indent-blankline.nvim",
  event = "LazyFile",
  opts = {
    indent = { highlight = highlight, char = "¦" },
    scope = {
      enabled = true,
      char = "▏",
      show_start = true,
      show_end = false,
      include = {
        node_type = {
          ["*"] = {
            "argument_list",
            "arguments",
            "assignment_statement",
            "Block",
            -- 'chunk',
            "class",
            "ContainerDecl",
            "dictionary",
            "do_block",
            "do_statement",
            "element",
            "elif_clause",
            "else_clause",
            "except",
            "FnCallArguments",
            "for",
            "for_statement",
            "function",
            "function_declaration",
            "function_definition",
            "if_clause",
            "if_statement",
            "IfExpr",
            "IfStatement",
            "import",
            "InitList",
            "list_literal",
            "method",
            "object",
            "ParamDeclList",
            "repeat_statement",
            "selector",
            "SwitchExpr",
            "table",
            "table_constructor",
            "try",
            "tuple",
            "type",
            "var",
            "while",
            "while_statement",
            "with",
            "with_statement",
          },
        },
      },
      injected_languages = false,
      highlight = highlight,
      priority = 500,
    },
    exclude = {
      filetypes = {
        "TelescopePrompt",
        "Trouble",
        "alpha",
        "dashboard",
        "help",
        "lazy",
        "lazyterm",
        "log",
        "lsp-installer",
        "lspinfo",
        "markdown",
        "mason",
        "neo-tree",
        "notify",
        "packer",
        "terminal",
        "toggleterm",
        "trouble",
      },
    },
  },
  main = "ibl",
}
