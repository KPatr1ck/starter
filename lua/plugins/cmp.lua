local cmp = require("cmp")
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmdline_mapping = cmp.mapping.preset.cmdline()
cmdline_mapping["<C-P>"] = cmp.mapping.complete()
cmdline_mapping["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
cmdline_mapping["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" })
cmdline_mapping["<Tab>"] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif has_words_before() then
    cmp.complete({
      reason = cmp.ContextReason.Auto,
    })
  else
    fallback()
  end
end, { "i", "c" })

return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    -- {
    --   "Exafunction/codeium.nvim",
    --   cmd = "Codeium",
    --   build = ":Codeium Auth",
    --   opts = {},
    -- },
  },
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    local defaults = require("cmp.config.default")()
    return {
      preselect = cmp.PreselectMode.None,
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        -- { name = "codeium" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
      mapping = cmdline_mapping,
      formatting = {
        format = function(_, item)
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          return item
        end,
      },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      sorting = defaults.sorting,
    }
  end,
  ---@param opts cmp.ConfigSchema
  config = function(_, opts)
    for _, source in ipairs(opts.sources) do
      source.group_index = source.group_index or 1
    end
    require("cmp").setup(opts)

    require("cmp").setup.cmdline("/", {
      mapping = cmdline_mapping,
      sources = {
        { name = "buffer" },
      },
    })

    require("cmp").setup.cmdline(":", {
      mapping = cmdline_mapping,
      sources = cmp.config.sources({
        { name = "path" },
      }, { { name = "cmdline" } }),
    })

    -- Load snippets from nvim-scissors
    require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
  end,
}
