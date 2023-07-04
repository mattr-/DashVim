-- Do basic config setup before loading plugins
require ("mattr-.config").init()

return {
  { "folke/lazy.nvim", version = "*" },
  { "mattr-/mattr-.nvim", priority = 10000, lazy = false, config = true, cond = true, version = "*" },
}
