local M = {}

function M.fg(name)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  local fg = hl and hl.fg or hl.foreground
  return fg and { fg = string.format("#%06x", fg) }
end

return M
