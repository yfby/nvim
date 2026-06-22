require("conform").setup {
  notify_on_error = true,
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    -- Don't format certain file types
    local ft = vim.bo[bufnr].filetype
    local ignored_fts = { "markdown", "text" }
    if vim.tbl_contains(ignored_fts, ft) then
      return
    end
    return {
      timeout_ms = 500,
      lsp_fallback = true,
      async = false,
    }
  end,
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format", "ruff_organize_imports" },
    javascript = { "prettier", "eslint_d" },
    typescript = { "prettier", "eslint_d" },
    javascriptreact = { "prettier", "eslint_d" },
    typescriptreact = { "prettier", "eslint_d" },
    jsx = { "prettier", "eslint_d" },
    tsx = { "prettier", "eslint_d" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    go = { "gofmt", "goimports" },
    rust = { "rustfmt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    css = { "prettier", "stylelint" },
    scss = { "prettier", "stylelint" },
    vue = { "prettier", "eslint" },
    svelte = { "prettier", "eslint" },
    html = { "prettier" },
    graphql = { "prettier" },
    java = { "google-java-format" },
    bash = { "shfmt" },
    sh = { "shfmt" },
  },
  formatters = {
    prettier = {
      condition = function(ctx)
        return vim.fn.executable("prettier") == 1
      end,
    },
    stylua = {
      condition = function(ctx)
        return vim.fn.executable("stylua") == 1
      end,
    },
    stylelint = {
      condition = function(ctx)
        return vim.fn.executable("stylelint") == 1
      end,
    },
    black = {
      condition = function(ctx)
        return vim.fn.executable("black") == 1
      end,
    },
    ruff_format = {
      condition = function(ctx)
        return vim.fn.executable("ruff") == 1
      end,
    },
    ruff_organize_imports = {
      condition = function(ctx)
        return vim.fn.executable("ruff") == 1
      end,
    },
    google_java_format = {
      condition = function(ctx)
        return vim.fn.executable("google-java-format") == 1
      end,
    },
    rustfmt = {
      condition = function(ctx)
        return vim.fn.executable("rustfmt") == 1
      end,
    },
  },
}
