--- @class DashVimConfig : DashVimOptions
local M = {}

--- @class DashVimOptions
local defaults = {
  colorscheme = "tokyonight",
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
  -- always load lazyvim, then user file
  if M.defaults[name] or name == "options" then
    _load("dashvim.config." .. name)
  end
  _load("config." .. name)

  if vim.bo.filetype == "lazy" then
    -- HACK: We may have overwritten options of the Lazy ui, so reset this here
    vim.cmd([[do VimResized]])
  end
  vim.api.nvim_exec_autocmds("User", { pattern = pattern, modeline = false })
end

function M.setup(opts)
  options = vim.tbl_deep_extend("force", defaults, opts or {}) or {}
end

return M
