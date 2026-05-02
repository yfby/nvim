-- Auto commands for modern Neovim

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
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

-- Remove tilde characters from end of buffer in dashboard, uncomment if eob is unset to " "
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "dashboard" },
--   callback = function()
--     vim.opt_local.fillchars = { eob = " " }
--   end,
-- })
