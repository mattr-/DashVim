-- This file is the very first one loaded from the framework by lazy.nvim
-- so we do a bit of setup in here.
if vim.fn.has("nvim-0.10.0") == 0 then
  vim.api.nvim_echo({
    { "DashVim requires neovim >= 0.10.0\n", "ErrorMsg" },
    { "\nPress any key to exit...", "MoreMsg" },
  }, true, {})
  vim.fn.getchar()
  vim.cmd([[quit]])
end

-- Do a minimal amount of early initialization
require("dashvim").init()

return {
  { "folke/lazy.nvim", version = "*" },
  { "mattr-/DashVim", priority = 10000, lazy = false, opts = {}, cond = true, version = "*" },
}
