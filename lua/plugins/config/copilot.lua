local ok, copilot = pcall(require, "copilot")
if not ok then
  return
end

copilot.setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<C-l>",
      accept_word = "<C-j>",
      next = "<C-]>",
      dismiss = "<C-[>",
    },
  },
  panel = { enabled = false },
  filetypes = {
    ["*"] = true,
  },
  copilot_node_command = "node",
  root_dir = function()
    return vim.loop.cwd() or "."
  end,
})
