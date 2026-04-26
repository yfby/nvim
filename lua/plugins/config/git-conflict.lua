require("git-conflict").setup({
  default_mappings = false,
  disable_diagnostics = false,
  hints = {
    show = true,
    priority = 100,
    region = "content",
  },
  highlights = {
    incoming = "DiffAdd",
    current = "DiffChange",
  },
  notification = {
    added_incoming = "Incomming changes",
    added_incoming_current = "Current changes",
    removed_incoming = "Removed in incoming",
    removed_current = "Removed in current",
  },
})

local keymap = vim.keymap.set

keymap("n", "<leader>gcn", function()
  require("git-conflict").choose_none()
end, { desc = "Conflict choose none" })
keymap("n", "<leader>gco", function()
  require("git-conflict").choose_ours()
end, { desc = "Conflict choose ours" })
keymap("n", "<leader>gct", function()
  require("git-conflict").choose_theirs()
end, { desc = "Conflict choose theirs" })
keymap("n", "<leader>gcb", function()
  require("git-conflict").choose_both()
end, { desc = "Conflict choose both" })
keymap("n", "<leader>gcc", function()
  require("git-conflict").choose_all()
end, { desc = "Conflict choose all" })
keymap("n", "<leader>gca", function()
  require("git-conflict").accept_current()
end, { desc = "Accept current" })
