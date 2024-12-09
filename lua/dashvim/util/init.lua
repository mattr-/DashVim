local LazyUtil = require("lazy.core.util")

--- @class dashvim.util: LazyUtilCore
--- @field lazy dashvim.util.lazy
local M = {}

setmetatable(M, {
  __index = function(table, key)
   -- Delegate to lazy's core utilities if a key matches a name in that class
    if LazyUtil[key] then
      return LazyUtil[key]
    end

    -- Otherwise, load a module from our util namespace
    table[key] = require("dashvim.util." .. key)
    return table[key]
  end,
})

return M
