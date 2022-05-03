local utils = require('rename.utils')

local M =  {}

M.handler = function(err, res, ctx, _)
  if err then
    vim.notify(("Error running LSP query '%s': %s"):format(ctx.method, err), "error")
    return
  end

  if not res then return end

  local client = vim.lsp.get_client_by_id(ctx.client_id)
  vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)

  if res and res.documentChanges then
    local msg = {}
    for _, changes in ipairs(res.documentChanges) do
      table.insert(msg, ('%d changes -> %s'):format(#changes.edits, utils.get_relative_path(changes.textDocument.uri)))
    end
    for _, content in ipairs(msg) do
      vim.notify(content)
    end
  end
end

return M
