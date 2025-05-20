_G.DashVim = require("dashvim.util")

---@class DashVimConfig :DashVimOptions
local M = {}

DashVim.config = M

---@class DashVimOptions
local defaults = {
  colorscheme = "catppuccin",
  icons = {
    diagnostics = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " ",
    },
    git = {
      added = " ",
      modified = " ",
      removed = " ",
    },
  },
}

local options

function M.setup(opts)
  options = vim.tbl_deep_extend("force", defaults, opts or {}) or {}

  local augroup = vim.api.nvim_create_augroup("DashVim", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    group = augroup,
    callback = function()
      M.cascade_load("autocmds")
      M.cascade_load("keymaps")
    end,
  })
end

--- @param name "autocmds" | "keymaps" | "options"
function M.cascade_load(name)
  function _try_load(mod)
    if require("lazy.core.cache").find(mod)[1] then
      require("lazy.core.util").try(function()
        require(mod)
      end, { msg = "Failed loading " .. mod })
    end
  end

  _try_load("dashvim.config." .. name)
  _try_load("config.".. name)
end

M.early_init_done = false
function M.early_init()
  if M.early_init_done then
    return
  end

  M.early_init_done = true

  -- Add our ourselves to RTP since we won't be loaded yet.
  local ourselves = require("lazy.core.config").spec.plugins.DashVim
  if ourselves then
    vim.opt.rtp:append(ourselves.dir)
  end

  M.cascade_load("options")
end

setmetatable(M, {
  __index = function(_, key)
    if options == nil then
      return vim.deepcopy(defaults)[key]
    end

    return options[key]
  end,
})

return M
