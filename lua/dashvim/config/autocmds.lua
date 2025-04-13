local function augroup(name)
  return vim.api.nvim_create_augroup("dashvim_" .. name, { clear = true })
end

-- Write all the files when we lose focus
vim.api.nvim_create_autocmd({ "FocusLost" }, {
  group = augroup("write_all"),
  command = "silent! wall",
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

