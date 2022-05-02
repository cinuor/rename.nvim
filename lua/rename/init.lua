local utils = require('rename.utils')
local M = {}

local default_border = 'rounded'
local default_user_opts = {
  notify_title = 'Rename',
  border_style = default_border,
  rename = {
    border = {
      highlight = 'FloatBorder',
      style = nil,
      title = 'Rename',
      title_align = 'left',
      title_hl = 'FloatBorder',
    },
    prompt = '➤ ',
    prompt_hl = 'Comment',
  },
}

M.user_opts = {}

M.setup = function(user_opts)
  -- get parsed user opts
  M.user_opts = utils.merge(default_user_opts, user_opts or {})
  user_opts = M.user_opts
end

M.rename = function(popup_opts, opts)
  return require('rename.rename')(popup_opts, opts)
end

return M
