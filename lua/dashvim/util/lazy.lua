---@class dashvim.util.lazy

local M = {}

---@param name string
function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

function M.get_plugin(name)
  return require("lazy.core.config").spec.plugins[name]
end

function M.has(plugin)
  return M.get_plugin(plugin) ~= nil
end

return M

