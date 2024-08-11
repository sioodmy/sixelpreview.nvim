# sixelpreview.nvim

simple nvim plugin to display markdown images in nvim using libsixel

## Usage

```lua
require("sixelpreview").current_line()
```

I have it mapped like this
```
nnoremap <leader><cr> <cmd>lua require("sixelpreview").current_line()<cr>
```

Use ctrl + l to clear image
