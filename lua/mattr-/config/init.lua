local M = {}

local defaults = {
  colorscheme = function()
    vim.cmd.colorscheme("habamax")
  end,
  -- load the default settings
  defaults = {
    autocmds = true, -- lazyvim.config.autocmds
    keymaps = true, -- lazyvim.config.keymaps
    -- mattr-.config.options can't be configured here since that's loaded before we do setup
    -- if you want to disable loading options, add `package.loaded["mattr-.config.options"] = true` to the top of your init.lua
  },
}


local options

function M.setup(opts)
  options = vim.tbl_deep_extend("force", defaults, opts or {})

  if vim.fn.argc(-1) == 0 then
    -- autocmds and keymaps can wait to load
    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
      pattern = "VeryLazy",
      callback = function()
        -- M.load("autocmds")
        -- M.load("keymaps")
      end,
    })
  else
    -- load them now so they affect the opened buffers
    --M.load("autocmds")
    --M.load("keymaps")
  end

  require("lazy.core.util").try(function()
    if type(M.colorscheme) == "function" then
      M.colorscheme()
    else
      vim.cmd.colorscheme(M.colorscheme)
    end
  end, {
    msg = "Could not load your colorscheme",
    on_error = function(msg)
      require("lazy.core.util").error(msg)
      vim.cmd.colorscheme("habamax")
    end,
  })
end

---@param name "autocmds" | "options" | "keymaps"
function M.load(name)
  local Util = require("lazy.core.util")
  local function _load(mod)
    Util.try(function()
      require(mod)
    end, {
      msg = "Failed loading " .. mod,
      on_error = function(msg)
        local info = require("lazy.core.cache").find(mod)
        if info == nil or (type(info) == "table" and #info == 0) then
          return
        end
        Util.error(msg)
      end,
    })
  end
  -- always load the defaults, then any user files
  if M.defaults[name] or name == "options" then
    _load("mattr-.config." .. name)
  end
  _load("config." .. name)
  if vim.bo.filetype == "lazy" then
    -- HACK: We may have overwritten options of the Lazy ui, so reset this here
    vim.cmd([[do VimResized]])
  end
  local pattern = "LazyVim" .. name:sub(1, 1):upper() .. name:sub(2)
  vim.api.nvim_exec_autocmds("User", { pattern = pattern, modeline = false })
end

M.did_init = false
function M.init()
  if not M.did_init then
    M.did_init = true
    -- delay notifications till vim.notify is replaced
    require("mattr-.util").lazy_notify()

    -- load options here, before lazy init while we're sourcing plugin modules
    -- this is needed to make sure options will be correctly applied after
    -- installing missing plugins
    require("mattr-.config").load("options")
  end
end

setmetatable(M, {
  __index = function(_, key)
    if options == nil then
      return vim.deepcopy(defaults)[key]
    end
    ---@cast options LazyVimConfig
    return options[key]
  end,
})


return M
