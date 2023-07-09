local M = {}

-- Take a function and call it when the LspAttach event fires
-- Allows us to separate plugin specific LSP attachment behavior rather than
-- having to mash it all together
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end
  })
end

return M
