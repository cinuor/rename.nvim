local lsp = vim.lsp
local utils = require('rename.utils')
local rename_handler = require('rename.rename.handler').handler
local Text = require('nui.text')
local config = require('rename').user_opts

local function rename(popup_opts, opts)
  local Input = require('nui.input')
  local event = require('nui.utils.autocmd').event
  local curr_name = vim.fn.expand('<cword>')

  local user_border = config.rename.border
  local width = 25
  if #curr_name > width then
    width = #curr_name
  end

  popup_opts = utils.merge({
    position = {
      row = 1,
      col = 0,
    },
    size = {
      width = width,
      height = 2,
    },
    relative = 'cursor',
    border = {
      highlight = user_border.highlight,
      style = user_border.style or config.border_style,
      text = {
        top = Text(user_border.title, user_border.title_hl),
        top_align = user_border.title_align,
      },
    },
  }, popup_opts or {})

  opts = utils.merge({
    prompt = Text(config.rename.prompt, config.rename.prompt_hl),
    default_value = curr_name,
    on_submit = function(new_name)
      if not (new_name and #new_name > 0) or new_name == curr_name then
        return
      end
      local params = lsp.util.make_position_params()
      params.newName = new_name
      lsp.buf_request(0, 'textDocument/rename', params, rename_handler)
    end,
  }, opts or {})

  local input = Input(popup_opts, opts)

  input:mount()

  utils.default_mappings(input)

  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

return rename
