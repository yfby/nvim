local ok, harpoon = pcall(require, "harpoon")
if not ok then
  return
end

harpoon.setup({
  global_settings = {
    save_on_toggle = true,
    sync_on_ui_close = true,
    mark_branch = false,
  },
})

vim.keymap.set("n", "<leader>ha", function()
  require("harpoon.mark").add_file()
end, { desc = "Harpoon add file" })

vim.keymap.set("n", "<leader>hh", function()
  require("harpoon.ui").toggle_quick_menu()
end, { desc = "Harpoon menu" })

vim.keymap.set("n", "<leader>h1", function()
  require("harpoon.ui").nav_file(1)
end, { desc = "Harpoon 1" })

vim.keymap.set("n", "<leader>h2", function()
  require("harpoon.ui").nav_file(2)
end, { desc = "Harpoon 2" })

vim.keymap.set("n", "<leader>h3", function()
  require("harpoon.ui").nav_file(3)
end, { desc = "Harpoon 3" })

vim.keymap.set("n", "<leader>h4", function()
  require("harpoon.ui").nav_file(4)
end, { desc = "Harpoon 4" })
