local M = {}

local plugin_config = require("lazy.core.config")

function M.opts(name)
  local plugin_config = require("lazy.core.config")
  local plugin = plugin_config.plugins[name]
  if not plugin then
    return {}
  end
  return plugin_config.values(plugin, "opts", false)
end

-- have we configured a plugin?
function M.has(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

return M
