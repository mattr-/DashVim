return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- use main for now, there's a rewrite happening in another branch
    build = ":TSUpdate",
    event = "LazyFile",
    lazy = vim.fn.argc(-1) == 0, -- load early if we have arguments
    -- treesitter has a lot of commands but we only load on the ones that don't
    -- involve buffers since we load treesitter as part of LazyFile
    cmd = {
      "TSInstall",
      "TSInstallSync",
      "TSInstallInfo",
      "TSUpdate",
      "TSUpdateSync",
      "TSUninstall",
    },
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "vim",
        "vimdoc"
      },
    }
  },
}
