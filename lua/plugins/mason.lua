return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    -- python
    table.insert(opts.ensure_installed, "autopep8")
    table.insert(opts.ensure_installed, "black")
    table.insert(opts.ensure_installed, "isort")
    table.insert(opts.ensure_installed, "yapf")
    -- lua
    table.insert(opts.ensure_installed, "lua-language-server")
    table.insert(opts.ensure_installed, "stylua")
    -- shell
    table.insert(opts.ensure_installed, "shfmt")
  end,
}
