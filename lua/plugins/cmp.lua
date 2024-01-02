return {
  -- cmp
  {
    "hrsh7th/nvim-cmp",
    config = function()
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

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "otter" },
        }, { { name = "buffer" }, { name = "path" } }),

        -- 快捷键设置
        mapping = cmdline_mapping,
        -- formatting = require("lsp.ui").formatting,
      })

      -- / 查找模式使用 buffer 源
      cmp.setup.cmdline("/", {
        mapping = cmdline_mapping,
        sources = {
          { name = "buffer" },
        },
      })

      -- : 命令行模式中使用 path 和 cmdline 源.
      cmp.setup.cmdline(":", {
        mapping = cmdline_mapping,
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
  { "hrsh7th/vim-vsnip" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
}
