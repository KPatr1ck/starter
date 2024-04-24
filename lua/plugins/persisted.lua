return {
  {
    "olimorris/persisted.nvim",
    commit = "ca9900c31ee6e254a0ba7011ba49f48ebf4c8db2",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    opts = {
      save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
      silent = false, -- silent nvim message when sourcing session file
      use_git_branch = false, -- create session files based on the branch of a git enabled repository
      default_branch = "main", -- the branch to load if a session file is not found for the current branch
      autosave = true, -- automatically save session files when exiting Neovim
      should_autosave = function()
        -- do not autosave if the alpha dashboard is the current filetype
        if vim.bo.filetype == "alpha" or vim.bo.filetype == "starter" then
          return false
        end
        return true
      end,
      autoload = false, -- automatically load the session for the cwd on Neovim startup
      on_autoload_no_session = nil, -- function to run when `autoload = true` but there is no session to load
      follow_cwd = true, -- change session file name to match current working directory if it changes
      allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
      ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
      ignored_branches = nil, -- table of branch patterns that are ignored for auto-saving and auto-loading
      telescope = {
        reset_prompt = true, -- Reset the Telescope prompt after an action?
        mappings = { -- table of mappings for the Telescope extension
          change_branch = "<c-b>",
          copy_session = "<c-p>",
          delete_session = "<c-d>",
        },
        icons = nil,
      },
    },
    config = function(_, opts)
      require("persisted").setup(opts)
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("persisted")
      end)
    end,
    keys = {
      -- { "<leader>fp", "<Cmd>Telescope persisted<CR>", desc = "Persisted" },
      { "<C-Home>", "<Cmd>Telescope persisted<CR>", desc = "Persisted" },
    },
  },
}
