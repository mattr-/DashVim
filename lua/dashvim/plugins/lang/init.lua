-- Languages don't need to be ordered.
-- Keep them in alphabetical order as you add them.
local languages = {
  "dashvim.plugins.lang.lua",
  "dashvim.plugins.lang.markdown"
}

---@param language string
return vim.tbl_map(function(language)
  return { import = language }
end, languages)
