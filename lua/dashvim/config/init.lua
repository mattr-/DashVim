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

--- @param name "autocmds" | "keymaps" | "options"
function M.cascade_load(name)
  function _try_load(mod)
    if require("lazy.core.cache").find(mod)[1] then
      require("lazy.core.util").try(function()
        require(mod)
      end, { msg = "Failed loading " .. mod })
    end
  end

  _try_load("dashvim.config." .. name)
  _try_load("config.".. name)
end

M.early_init_done = false
function M.early_init()
  if M.early_init_done then
    return
  end

  M.cascade_load("options")
  M.cascade_load("autocmds")
  M.cascade_load("keymaps")
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
