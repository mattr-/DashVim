---@class dashvim.util.telescope
local M = {}

function M.config_files()
  local Telescope = require("telescope.builtin")
  Telescope.find_files({cwd = vim.fn.stdpath("config")})
end

function M.plugin_files()
  local Telescope = require("telescope.builtin")
  Telescope.find_files({cwd = vim.fn.stdpath("data") .. "/lazy"})
end


--If we don't have something here, delegate to a telescope builtin
return setmetatable({}, {
  __index = function(_, k)
  if M[k] then
    return M[k]
  else
    return require("telescope.builtin")[k]
  end
end
})
