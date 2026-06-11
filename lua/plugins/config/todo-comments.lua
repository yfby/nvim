require("todo-comments").setup({
  signs = true,
  sign_priority = 10,
  keywords = {
    FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG" } },
    TODO = { icon = "󰍨 ", color = "info" },
    HACK = { icon = "󰌗 ", color = "warning" },
    WARN = { icon = "󰌗 ", color = "warning", alt = { "WARNING" } },
    PERF = { icon = "󰏙 ", color = "warning", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = "󰎙 ", color = "hint", alt = { "INFO" } },
    TEST = { icon = "󰰓 ", color = "test", alt = { "TESTING", "TESTS" } },
  },
  merge_keywords = true,
  highlight = {
    comments_only = true,
    max_line_len = 120,
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
    args = { "--column", "--case-sensitive" },
    highlight = {
      icon = " ",
    },
  },
})
