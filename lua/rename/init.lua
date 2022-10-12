local M = {}

M.rename = function(opts)
    opts = opts or {}
    opts.default = vim.fn.expand('<cword>')
    return require('rename.rename')(opts)
end

return M
