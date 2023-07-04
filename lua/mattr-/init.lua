local M = {}

--[[
lazy.nvim will automatically call a main module's setup function when loading a plugin. This lets us pretend we're a plugin and use lazy's plugin handling
--]]
function M.setup(opts)
  require("mattr-.config").setup(opts)
end

return M
