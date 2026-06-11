local lint = require("lint")

-- Configure linters by filetype
lint.linters_by_ft = {
  python = { "pylint", "flake8" },
  javascript = { "eslint" },
  typescript = { "eslint" },
  javascriptreact = { "eslint" },
  typescriptreact = { "eslint" },
  lua = { "luacheck" },
  bash = { "shellcheck" },
  sh = { "shellcheck" },
  yaml = { "yamllint" },
  json = { "jsonlint" },
  rust = { "clippy" },
  go = { "golangci-lint" },
  markdown = { "markdownlint" },
  css = { "stylelint" },
  scss = { "stylelint" },
  vue = { "eslint", "stylelint" },
  svelte = { "eslint" },
  dockerfile = { "hadolint" },
  java = { "checkstyle" },
  jsonc = { "eslint" },
}

-- Lint on file events
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
