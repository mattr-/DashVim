local LazyUtil = require("lazy.core.util")

---@class dashvim.util.lazy : LazyUtilCore
local M = {}

setmetatable(M, {
  __index = function(table, key)
    -- Delegate to lazy's core utilities if a key matches a name in that class
    if LazyUtil[key] then
      return LazyUtil[key]
    end
})

return M
