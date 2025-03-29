---@class DashVim

local M = {}

function M.setup(opts)
  -- Load our config module, passing opts through in case folks want to
  -- override the defaults
  require("dashvim.config").setup(opts)
end

setmetatable(M, {
  __index = function(t, k)
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("dashvim." .. k)
    return t[k]
  end,
})

return M

