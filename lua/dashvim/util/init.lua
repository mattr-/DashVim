
--- @class dashvim.util: LazyUtilCore
--- @field dashvim.lazy: dashvim.util.lazy
local M = {}

setmetatable(M, {
  __index = function(table, key)
    -- Load a module from our util namespace if available
    table[key] = require("dashvim.util." .. key)
    return table[key]
  end,
})

return M

