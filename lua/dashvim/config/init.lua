--- @class DashVimConfig : DashVimOptions
local M = {}

--- @class DashVimOptions
local defaults = {
  colorscheme = "tokyonight",
  defaults = {
    autocmds = true, -- dashvim.config.autocmds
    keymaps = true, -- dashvim.config.keymaps
    -- options cannot be configured here. they load before setup
    -- use `package.loaded["dashvim.config.options"] = true` to the top of your init.lua
  },
  icons = {
    dap = {
      Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint = " ",
      BreakpointCondition = " ",
      BreakpointRejected = { " ", "DiagnosticError" },
      LogPoint = ".>",
    },
    diagnostics = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " ",
    },
    git = {
      added = " ",
      modified = " ",
      removed = " ",
    },
    kinds = {
      Array = " ",
      Boolean = " ",
      Class = " ",
      Color = " ",
      Constant = " ",
      Constructor = " ",
      Copilot = " ",
      Enum = " ",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Folder = " ",
      Function = " ",
      Interface = " ",
      Key = " ",
      Keyword = " ",
      Method = " ",
      Module = " ",
      Namespace = " ",
      Null = " ",
      Number = " ",
      Object = " ",
      Operator = " ",
      Package = " ",
      Property = " ",
      Reference = " ",
      Snippet = " ",
      String = " ",
      Struct = " ",
      Text = " ",
      TypeParameter = " ",
      Unit = " ",
      Value = " ",
      Variable = " ",
    },
  },
}

local options
setmetatable(M, {
  __index = function(_, key)
    if options == nil then
      return vim.deepcopy(defaults)[key]
    end

    ---@cast options DashVimConfig
    return options[key]
  end,
})

---@param name "autocmds" | "options" | "keymaps"
function M.load(name)
  local function _load(mod)
    require("lazy.core.util").try(function()
      require(mod)
    end, {
        msg = "Failed loading " .. mod,
        on_error = function(msg)
          local info = require("lazy.core.cache").find(mod)
          if info == nil or (type(info) == "table" and #info == 0) then
            return
          end
          vim.notify(message, vim.log.levels.ERROR, {})
        end,

      })
  end
  -- always load ours, then user file
  if M.defaults[name] or name == "options" then
    _load("dashvim.config." .. name)
  end
  _load("config." .. name)

  if vim.bo.filetype == "lazy" then
    -- HACK: We may have overwritten options of the Lazy ui, so reset this here
    vim.cmd([[do VimResized]])
  end
end

function M.setup(opts)
  options = vim.tbl_deep_extend("force", defaults, opts or {}) or {}

  -- autocmds can be loaded lazily when not opening a file
  local lazy_autocmds = vim.fn.argc(-1) == 0
  if not lazy_autocmds then
    M.load("autocmds")
  end

  -- Load autocmds and keymaps during VeryLazy (which is very close to VimEnter)
  local group = vim.api.nvim_create_augroup("DashVim", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "VeryLazy",
    callback = function()
      if lazy_autocmds then
        M.load("autocmds")
      end
      M.load("keymaps")
    end,
  })

  -- Setup the colorscheme
  DashVim.track("colorscheme")
  DashVim.try(function()
    if type(M.colorscheme) == "function" then
      M.colorscheme()
    else
      vim.cmd.colorscheme(M.colorscheme)
    end
  end, {
    msg = "Could not load your colorscheme",
    on_error = function(msg)
      DashVim.error(msg)
      vim.cmd.colorscheme("habamax")
    end,
  })
  DashVim.track()
end

return M
