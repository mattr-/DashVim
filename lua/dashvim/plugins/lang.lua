local language_plugins = {
  "dashvim.plugins.lang.lua",
  "dashvim.plugins.lang.markdown",
  "dashvim.plugins.lang.rust",
};

return vim.tbl_map(function(language)
  return { import = language }
end, language_plugins)
