_G.DashVim = require("dashvim")
---@class dashvim.config
local M = {}

---@class DashVimOptions
local defaults = {
  colorscheme = "catppuccin",
  icons = {
    diagnostics = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " ",
    },
  },
}

local options

function M.setup(opts)
  options = vim.tbl_deep_extend("force", defaults, opts or {}) or {}
end

M.early_init_done = false
function M.early_init()
  if M.early_init_done then
    return
  end

  require("dashvim.config.options")
  require("dashvim.config.autocmds")
  require("dashvim.config.keymaps")
end

setmetatable(M, {
  __index = function(_, key)
    if options == nil then
      return defaults[key]
    end

    return options[key]
  end,
})

return M
