-- Auto commands for modern Neovim

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "ts_install" then
      vim.cmd("bufdo bufdelete")
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "help", "man" },
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dashboard" },
  callback = function()
    vim.opt_local.fillchars = { eob = " " }
  end,
})

-- Auto-resize splits when terminal window is resized
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("wincmd =")
  end,
})

-- -- Disable statuscolumn for sidebar windows
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "NvimTree", "neo-tree", "aerial", "edgy", "trouble", "qf", "help", "man" },
--   callback = function()
--     vim.opt_local.statuscolumn = ""
--   end,
-- })
