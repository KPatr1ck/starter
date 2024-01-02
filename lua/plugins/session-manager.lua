return {
  "Shatur/neovim-session-manager",
  config = function()
    local config = require("session_manager.config")
    local utils = require("session_manager.utils")
    require("session_manager").setup({
      sessions_dir = vim.fn.stdpath("data") .. "/sessions/",
      autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments.
      autosave_last_session = true, -- Automatically save last session on exit and on session switch.
      autosave_ignore_not_normal = true,
      autosave_ignore_dirs = { "~" },
      autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
        "ccc-ui",
        "gitcommit",
        "gitrebase",
        "qf",
        "neo-tree",
        "floaterm",
        "Trouble",
      },
      autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
    })
  end,
}
