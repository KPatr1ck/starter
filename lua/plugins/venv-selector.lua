return {
  "linux-cultist/venv-selector.nvim",
  opts = function(_, opts)
    if require("lazyvim.util").has("nvim-dap-python") then
      opts.dap_enabled = true
    end

    return vim.tbl_deep_extend("force", opts, {
      anaconda_base_path = "$HOME/anaconda3",
      anaconda_envs_path = "$HOME/anaconda3/envs",
      parents = 0,
    })
  end,
}
