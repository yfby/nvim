vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require("ufo").setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { "treesitter", "indent" }
  end,
})

local function has_ufo()
  return pcall(require, "ufo")
end

vim.keymap.set("n", "zR", function()
  if has_ufo() then require("ufo").openAllFolds() end
end, { desc = "Open all folds" })

vim.keymap.set("n", "zM", function()
  if has_ufo() then require("ufo").closeAllFolds() end
end, { desc = "Close all folds" })

vim.keymap.set("n", "zr", function()
  if has_ufo() then require("ufo").openFoldsExceptKinds() end
end, { desc = "Open folds except kinds" })

vim.keymap.set("n", "zm", function()
  if has_ufo() then require("ufo").closeFoldsExceptKinds() end
end, { desc = "Close folds except kinds" })
