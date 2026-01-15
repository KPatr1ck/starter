return {
  "luukvbaal/statuscol.nvim",
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      relculright = false,
      ft_ignore = {
        "notify",
        "cmp_menu",
        "noice",
        "flash_prompt",
        "neo-tree",
        "aerial",
        "trouble",
        "floaterm",
      },
      segments = {
        {
          text = { builtin.foldfunc },
          click = "v:lua.ScFa",
        },
        {
          sign = {
            namespace = { "diagnostic" },
            name = { ".*" },
            maxwidth = 1,
            colwidth = 2,
            auto = false,
          },
          click = "v:lua.ScSa",
        },
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
        { text = { " " } },
        {
          sign = { namespace = { "gitsigns" }, name = { ".*" }, maxwidth = 1, colwidth = 2, auto = false },
          click = "v:lua.ScSa",
        },
      },
    })
  end,
}
