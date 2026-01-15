return {
  "snacks.nvim",
  priority = 1000,
  opts = {
    scroll = { enabled = false },
    indent = { enabled = false },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
  ██ ▄█▀ ██▓███   ▄▄▄      ▄▄▄█████▓ ██▀███   ██▓ ▄████▄   ██ ▄█▀
  ██▄█▒ ▓██░  ██▒▒████▄    ▓  ██▒ ▓▒▓██ ▒ ██▒▓██▒▒██▀ ▀█   ██▄█▒
 ▓███▄░ ▓██░ ██▓▒▒██  ▀█▄  ▒ ▓██░ ▒░▓██ ░▄█ ▒▒██▒▒▓█    ▄ ▓███▄░
 ▓██ █▄ ▒██▄█▓▒ ▒░██▄▄▄▄██ ░ ▓██▓ ░ ▒██▀▀█▄  ░██░▒▓▓▄ ▄██▒▓██ █▄
 ▒██▒ █▄▒██▒ ░  ░ ▓█   ▓██▒  ▒██▒ ░ ░██▓ ▒██▒░██░▒ ▓███▀ ░▒██▒ █▄
 ▒ ▒▒ ▓▒▒▓▒░ ░  ░ ▒▒   ▓▒█░  ▒ ░░   ░ ▒▓ ░▒▓░░▓  ░ ░▒ ▒  ░▒ ▒▒ ▓▒
 ░ ░▒ ▒░░▒ ░       ▒   ▒▒ ░    ░      ░▒ ░ ▒░ ▒ ░  ░  ▒   ░ ░▒ ▒░
 ░ ░░ ░ ░░         ░   ▒     ░        ░░   ░  ▒ ░░        ░ ░░ ░
 ░  ░                  ░  ░            ░      ░  ░ ░      ░  ░
]],
        keys = {
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = function()
              require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
            end,
          },
          { icon = " ", key = "e", desc = "Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "f", desc = "Find file", action = ":Telescope find_files" },
          { icon = " ", key = "r", desc = "Recent files", action = ":Telescope oldfiles" },
          { icon = " ", key = "g", desc = "Grep text", action = ":Telescope live_grep" },
          { icon = " ", key = "p", desc = "Projects", action = ":Telescope persisted" },
          { icon = " ", key = "n", desc = "New file", action = ":ene | startinsert" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
  config = function(_, opts)
    -- 设置 snacks
    require("snacks").setup(opts)
  end,
}
