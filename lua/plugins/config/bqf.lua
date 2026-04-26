require("bqf").setup({
  filter = {
    separator = nil,
    magic = true,
  },
  preview = {
    border = { "┌", "─", "┐", "│", "┘", "│", "└", "│" },
    hidden = "all",
    should_split_cb = function(layout)
      local preview_win = layout.preview_win
      if preview_win and preview_win.valid then
        return false
      end
      return not vim.tbl_isempty(vim.b.qf_entries)
    end,
  },
  func_bar = {
    enable = true,
    component = "abbr",
  },
})
