local M = {}

--@param opts DashVimConfig
function M.setup(opts)
  -- Load our config module, passing opts through in case folks want to
  -- override the defaults
  require("dashvim.config").setup(opts)
end

return M
