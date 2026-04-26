require("goto-preview").setup({
  width = 120,
  height = 30,
  border = { "↖", "─", "╮", "│", "╯", "─", "╰", "│" },
  default_mappings = true,
  debug = false,
  opacity = nil,
  post_open_hook = nil,
})

vim.keymap.set("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { desc = "Peek definition" })
vim.keymap.set("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", { desc = "Peek type definition" })
vim.keymap.set("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", { desc = "Peek references" })
vim.keymap.set("n", "gP", "<cmd>lua require('goto-preview').close()<CR>", { desc = "Close preview" })
