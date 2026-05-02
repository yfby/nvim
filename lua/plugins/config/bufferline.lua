-- File Tabs
require("bufferline").setup {
  options = {
    themable = true,
    show_close_icon = true,
    color_icons = true,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true,
      },
    },
    indicator = {
      style = "underline",
    },
  },
}
