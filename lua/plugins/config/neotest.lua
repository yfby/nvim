require("neotest").setup({
  adapters = {},
  strategies = {
    integrated = {
      height = 20,
      width = 80,
    },
  },
  output = {
    open_on_run = "short",
  },
  summary = {
    animate = true,
    enabled = true,
    width = 60,
    signs = true,
  },
  run = {
    interactive = true,
  },
  diagnostic = {
    enabled = true,
  },
  icons = {
    child_indent = "│",
    child_prefix = "├",
    collapsed = "󰅂 ",
    expanded = "󰅀 ",
    failed = "󰀿 ",
    final_child_indent = " ",
    final_child_prefix = "╰",
    non_collapsible = "󰅂 ",
    passed = "󰀲 ",
    running = "󰑑 ",
    skipped = "󰌶 ",
    unknown = "󰀙 ",
  },
})
