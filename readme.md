# Rename

## 🛠 Installation

```lua
  use({
    'cinuor/rename',
    requires = 'nvim-lua/plenary.nvim',
  })
```

## ⚙️ Configuration

use `vim.ui.input` to handle input
you can use [dressing.nvim](https://github.com/stevearc/dressing.nvim) or [nui.nvim](https://github.com/MunifTanjim/nui.nvim) to replace builtin `vim.ui.input`

For example, nui.nvim
```lua
    use({
        'MunifTanjim/nui.nvim',
        config = function()
            local Input = require("nui.input")
            local event = require("nui.utils.autocmd").event
            local popup_options = {
                relative = "cursor",
                position = {
                    row = 1,
                    col = 0,
                },
                size = 20,
                border = {
                    style = "rounded",
                    text = {
                        top = "Input",
                        top_align = "left",
                    }
                },
                win_options = {
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
            }

            local custom_input = function(opts, on_confirm)
                popup_options.border.text.top = opts and opts.label or "Input"
                local default_opts = {
                    prompt = opts and opts.prompt or "➤ ",
                    on_submit = function(value)
                        local ok, _ = pcall(on_confirm, value)
                        if not ok then
                            vim.notify("Failed to run function", vim.log.levels.ERROR)
                        end
                    end
                }
                if opts and opts.default then
                    default_opts.default_value = opts.default
                end

                local input = Input(popup_options, default_opts)
                input:map("i", "<Esc>", input.input_props.on_close, { noremap = true })
                input:map("i", "<C-c>", input.input_props.on_close, { noremap = true })
                input:mount()
                input:on(event.BufLeave, function()
                    input:unmount()
                end)
            end
            vim.ui.input = custom_input
        end
    })
```

## ✨ Usage
```lua
lua require('rename').rename({label='Rename'})
```
