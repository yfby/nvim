require("persisted").setup({
  save_dir = vim.fn.stdpath("data") .. "/sessions/",
  command = "VimLeavePre",
  autostart = true,
  autoload = true,
  should_save = function()
    if vim.bo.filetype == "dashboard" then
      return false
    end
    return true
  end,
  telescope = {
    mappings = {
      load_session = "<CR>",
      delete_session = "<C-d>",
    },
    before_source = function()
      -- Close all buffers before loading session
      vim.cmd("bufdo bd!")
    end,
  },
  hooks = {
    before_save = function()
      return vim.fn.getcwd()
    end,
    after_save = function()
      vim.notify("Session saved!", vim.log.levels.INFO)
    end,
    on_autoload_no_session = function()
      vim.notify("No session to restore", vim.log.levels.INFO)
    end,
  },
})

-- Telescope extension for session browsing
local ok, telescope = pcall(require, "telescope")
if ok then
  pcall(telescope.load_extension, "persisted")
end
