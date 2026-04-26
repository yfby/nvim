require("persisted").setup({
  save_dir = vim.fn.stdpath("data") .. "/sessions/",
  command = "VimLeavePre",
  telescope = {
    reset_prompt_after_save = true,
  },
})
