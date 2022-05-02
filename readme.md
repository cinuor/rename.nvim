# Rename Floating Popup

## 🛠 Installation

```lua
  use({
    'cinuor/rename',
    requires = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
      require('rename').setup()
    end,
  })
```

## ⚙️ Configuration

```lua
{
  -- default border to use
  -- 'single', 'double', 'rounded', 'solid', 'shadow'
  border_style = 'rounded',

  -- rename popup settings
  rename = {
    border = {
      highlight = 'FloatBorder',
      style = 'single',
      title = ' Rename ',
      title_align = 'left',
      title_hl = 'FloatBorder',
    },
    prompt = '> ',
    prompt_hl = 'Comment',
  },
}
```

## ✨ Usage

### Rename

```lua
function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', 'gn', '<cmd>lua require("rename").rename()<cr>')
```
