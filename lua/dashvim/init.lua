_G.DashVim = require("dashvim.util")

local M = {}

M.did_init = false
function M.init()
  if not M.did_init then
    M.did_init = true
    -- load options first (before lazy.nvim init)
    -- this is needed to make sure options will be correctly applied
    -- after installing missing plugins
    require("dashvim.config").load("options")
  end
end

function M.setup(opts)
  require("dashvim.config").setup(opts)
end

return M
