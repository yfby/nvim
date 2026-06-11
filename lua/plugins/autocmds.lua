-- Auto commands for modern Neovim

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    -- Support different Neovim versions: prefer vim.highlight.on_yank, fallback to vim.hl.on_yank
    if type(vim.highlight) == "table" and type(vim.highlight.on_yank) == "function" then
      vim.highlight.on_yank()
    elseif type(vim.hl) == "table" and type(vim.hl.on_yank) == "function" then
      vim.hl.on_yank()
    end
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
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dashboard" },
  callback = function()
    vim.opt_local.fillchars = { eob = " " }
  end,
})
