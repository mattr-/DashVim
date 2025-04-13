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

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
