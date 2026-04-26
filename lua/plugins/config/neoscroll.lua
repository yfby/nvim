-- Neoscroll configuration
require("neoscroll").setup({
  mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>" },
  hide_cursor = true,
  stop_eof = true,
  respect_scrolloff = true,
  cursor_scrolls_alone = true,
})
