-- Autopairs with CMP integration
local npairs = require("nvim-autopairs")

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = { "string" },
    javascript = { "template_string" },
    java = false,
  },
  fast_wrap = {
    map = "<M-e>",
  },
})

-- CMP integration: auto-close brackets/quotes when selecting completion items
local ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if ok then
  local cmp_ok, cmp = pcall(require, "cmp")
  if cmp_ok then
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end
end
