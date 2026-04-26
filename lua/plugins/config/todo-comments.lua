require("todo-comments").setup({
  signs = true,
  sign_priority = { rust = 10 },
  keywords = {
    FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "HACK" } },
    TODO = { icon = "󰍨 ", color = "info" },
    HACK = { icon = "󰌗 ", color = "warning" },
    WARN = { icon = "󰌗 ", color = "warning", alt = { "WARNING" } },
    PERF = { icon = "󰏙 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = "󰎙 ", color = "hint", alt = { "INFO" } },
    TEST = { icon = "󰰓 ", color = "test", alt = { "TESTING", "TESTS" } },
  },
  merge_keywords = true,
  highlight = {
    comments_only = true,
    max_line_length = 120,
    disable = nil,
  },
  colors = {
    error = { "DiagnosticError", "ErrorMsg", "TSError" },
    warning = { "DiagnosticWarn", "WarningMsg", "TSWarning" },
    info = { "DiagnosticInfo", "TSInfo" },
    hint = { "DiagnosticHint", "TSHint" },
    test = { "TSLabel", "label" },
  },
  search = {
    command = "rg",
    args = { "--case-sensitive" },
    regex_keywords = "FIX|FIXME|BUG|HACK|TODO|WARN|WARNING|PERF|OPTIM|PERFORMANCE|OPTIMIZE|NOTE|INFO|TEST|TESTING|TESTS",
    highlight = {
      icon = "󰌘 ",
    },
  },
})
