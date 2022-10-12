local lsp = vim.lsp
local rename_handler = require('rename.rename.handler').handler

local on_confirm = function(new_name)
    local curr_name = vim.fn.expand('<cword>')
    if not (new_name and #new_name > 0) or new_name == curr_name then
        return
    end
    local params = lsp.util.make_position_params()
    params.newName = new_name
    lsp.buf_request(0, 'textDocument/rename', params, rename_handler)
end

local rename = function(opts)
    vim.ui.input(opts, on_confirm)
end

return rename
