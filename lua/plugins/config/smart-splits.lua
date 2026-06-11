-- Smart Splits configuration
require("smart-splits").setup {
  ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
  ignored_buffer_names = { "NvimTree", "neo-tree", "Outline" },
  cursor_follows_focus = false,
  at_edge = "resize",
  tmux_integration = true,
}
