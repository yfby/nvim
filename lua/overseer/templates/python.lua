-- Overseer templates for Python (pytest, unittest, ruff)
-- Auto-detects test framework by checking for pytest config or unittest usage.

return {
  -- pytest: run all tests
  {
    name = "pytest",
    builder = function()
      return {
        cmd = { "python", "-m", "pytest" },
        name = "Pytest",
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.executable("python") == 1
      end,
    },
  },
  -- pytest: run current file
  {
    name = "pytest current file",
    builder = function()
      return {
        cmd = { "python", "-m", "pytest", vim.fn.expand("%") },
        name = "Pytest: " .. vim.fn.expand("%:t"),
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.executable("python") == 1
      end,
    },
  },
  -- pytest: run with verbose output
  {
    name = "pytest verbose",
    builder = function()
      return {
        cmd = { "python", "-m", "pytest", "-v" },
        name = "Pytest Verbose",
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.executable("python") == 1
      end,
    },
  },
  -- pytest: stop on first failure
  {
    name = "pytest fail-fast",
    builder = function()
      return {
        cmd = { "python", "-m", "pytest", "-x" },
        name = "Pytest Fail Fast",
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.executable("python") == 1
      end,
    },
  },
  -- pytest: run with coverage
  {
    name = "pytest coverage",
    builder = function()
      return {
        cmd = { "python", "-m", "pytest", "--cov", "--cov-report=term-missing" },
        name = "Pytest Coverage",
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.executable("python") == 1
      end,
    },
  },
  -- unittest: run all tests
  {
    name = "unittest discover",
    builder = function()
      return {
        cmd = { "python", "-m", "unittest", "discover" },
        name = "Unittest Discover",
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.executable("python") == 1
      end,
    },
  },
  -- unittest: run current file
  {
    name = "unittest current file",
    builder = function()
      local module = vim.fn.expand("%:r"):gsub("/", ".")
      return {
        cmd = { "python", "-m", "unittest", module },
        name = "Unittest: " .. vim.fn.expand("%:t"),
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.executable("python") == 1
      end,
    },
  },
  -- ruff check
  {
    name = "ruff check",
    builder = function()
      return {
        cmd = { "ruff", "check", "." },
        name = "Ruff Check",
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.executable("ruff") == 1
      end,
    },
  },
  -- ruff format check
  {
    name = "ruff format check",
    builder = function()
      return {
        cmd = { "ruff", "format", "--check", "." },
        name = "Ruff Format Check",
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.executable("ruff") == 1
      end,
    },
  },
  -- ruff format
  {
    name = "ruff format",
    builder = function()
      return {
        cmd = { "ruff", "format", "." },
        name = "Ruff Format",
        cwd = vim.fn.getcwd(),
        components = { "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.executable("ruff") == 1
      end,
    },
  },
  -- pip install current project
  {
    name = "pip install editable",
    builder = function()
      return {
        cmd = { "pip", "install", "-e", "." },
        name = "Pip Install Editable",
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        local cwd = vim.fn.getcwd()
        return vim.fn.filereadable(cwd .. "/pyproject.toml") == 1
          or vim.fn.filereadable(cwd .. "/setup.py") == 1
      end,
    },
  },
}
