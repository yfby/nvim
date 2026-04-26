vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require("ufo").setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { "treesitter", "indent" }
  end,
})

vim.keymap.set("n", "zR", function()
  require("ufo").openAllFolds()
end, { desc = "Open all folds" })

vim.keymap.set("n", "zM", function()
  require("ufo").closeAllFolds()
end, { desc = "Close all folds" })

vim.keymap.set("n", "zr", function()
  require("ufo").openFoldsExceptKinds()
end, { desc = "Open folds except kinds" })

vim.keymap.set("n", "zm", function()
  require("ufo").closeFoldsExceptKinds()
end, { desc = "Close folds except kinds" })
