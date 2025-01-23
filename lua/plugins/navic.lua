local trouble_hls = require("trouble.config.highlights").colors

for k, v in pairs(trouble_hls) do
  vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, link = v })
  if k:sub(1, 4) == "Icon" then
    local icon_type = k:sub(5)
    vim.api.nvim_set_hl(0, "NavicIcons" .. icon_type, { default = true, link = v })
  end
end
vim.api.nvim_set_hl(0, "NavicText", { default = true, link = "Normal" })
vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, fg = "#F23456" })

return {
  "SmiteshP/nvim-navic",
  lazy = true,
  init = function()
    vim.g.navic_silence = true
    LazyVim.lsp.on_attach(function(client, buffer)
      if client.supports_method("textDocument/documentSymbol") then
        require("nvim-navic").attach(client, buffer)
        vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
      end
    end)
  end,
  opts = function()
    return {
      separator = "  ",
      highlight = true,
      depth_limit = 5,
      icons = LazyVim.config.icons.kinds,
      lazy_update_context = false,
    }
  end,
}
