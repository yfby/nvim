require("colorizer").setup {
  filetypes = {
    "*",
    "!lsp",
  },
  user_default_options = {
    names = false,
    rgb_fn = true,
    hsl_fn = true,
    css = true,
    css_fn = true,
    mode = "background",
    alpha = 0,
    tailwind = "both",
    virtualtext = "■",
    virtualtext_inline = false,
    virtualtext_mode = "foreground",
    always_update = false,
  },
}
