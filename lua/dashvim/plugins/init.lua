require("dashvim.config.options")

return
{
  { "folke/lazy.nvim", version = "*" },
  { "mattr-/DashVim", priority = 10000, lazy = false, cond = true, version = "*" },
  { "folke/snacks.nvim", priority = 1000, lazy = false },
}
