-- DAP (Debug Adapter Protocol) configuration
-- Provides debugging for Python, Node.js, Go, Rust, and C/C++.
--
-- Python configs auto-detect Django vs FastAPI projects by checking for
-- manage.py and pyproject.toml respectively. This means you can just hit
-- <leader>dc in any Python project and it picks the right entry point.
--
-- Remote attach configs are included for debugging Docker containers or
-- remote processes that expose a debug port.
--
-- DAP UI auto-opens when debugging starts and auto-closes when it ends.
local dap = require("dap")
local dapui = require("dapui")

-- Python DAP setup (using nvim-dap-python)
pcall(function()
  require("dap-python").setup("python")
end)

-- Python DAP configuration
-- The launch config auto-detects the project framework:
--   manage.py exists  -> Django (runserver --noreload)
--   pyproject.toml    -> FastAPI (--reload)
--   neither           -> plain Python
-- VIRTUAL_ENV is respected if set, otherwise falls back to system python.
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Python: Django/FastAPI",
    module = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.filereadable(cwd .. "/manage.py") then
        return "django"
      elseif vim.fn.filereadable(cwd .. "/pyproject.toml") then
        return "fastapi"
      else
        return "python"
      end
    end,
    args = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.filereadable(cwd .. "/manage.py") then
        return { "runserver", "--noreload" }
      elseif vim.fn.filereadable(cwd .. "/pyproject.toml") then
        return { "--reload" }
      end
      return {}
    end,
    cwd = "${workspaceFolder}",
    env = function()
      local env = {}
      local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        env.VIRTUAL_ENV = venv
      end
      return env
    end,
    pythonPath = function()
      local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        return venv .. "/bin/python"
      end
      return "python"
    end,
  },
  {
    type = "python",
    request = "attach",
    name = "Python: Attach to remote",
    connect = {
      host = "localhost",
      port = 5678,
    },
    django = true,
    justMyCode = true,
  },
}

-- Node.js DAP configuration
-- Three launch options:
--   Express/React: standard node --inspect-brk on port 9229
--   Nodemon:       uses npx nodemon --inspect for auto-restart on file changes
--   ts-node:       directly debugs TypeScript files via npx ts-node
dap.configurations.node = {
  {
    type = "node",
    request = "launch",
    name = "Node: Express/React (port 9229)",
    runtimeExecutable = "node",
    runtimeArgs = { "--inspect-brk=9229" },
    program = "${workspaceFolder}/${relativeFile}",
    cwd = "${workspaceFolder}",
    consoleKind = "integratedTerminal",
  },
  {
    type = "node",
    request = "launch",
    name = "Node: Nodemon",
    runtimeExecutable = "npx",
    runtimeArgs = { "nodemon", "--inspect" },
    program = "${workspaceFolder}/${relativeFile}",
    cwd = "${workspaceFolder}",
    consoleKind = "integratedTerminal",
  },
  {
    type = "node",
    request = "launch",
    name = "Node: Current File (with ts-node)",
    runtimeExecutable = "npx",
    runtimeArgs = { "ts-node" },
    program = "${workspaceFolder}/${relativeFile}",
    cwd = "${workspaceFolder}",
  },
}

-- Go DAP configuration
-- Launch mode runs the current file; test mode runs tests in the current file.
-- Attach mode lets you connect to a running Go process via process picker.
-- Requires the delve debugger (`dlv`) to be installed.
dap.configurations.go = {
  {
    type = "go",
    request = "launch",
    name = "Go: Launch file",
    program = "${workspaceFolder}/${relativeFile}",
    cwd = "${workspaceFolder}",
    buildFlags = "",
  },
  {
    type = "go",
    request = "launch",
    name = "Go: Launch test",
    mode = "test",
    program = "${workspaceFolder}/${relativeFile}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "go",
    request = "attach",
    name = "Go: Attach to process",
    mode = "local",
    processId = "${command:pickProcess}",
  },
}

-- Rust DAP configuration
-- Builds the project with `cargo build` before launching.
-- The binary name matches the workspace folder name (convention for single-binary crates).
-- Uses codelldb as the debug adapter (installed via mason-nvim-dap).
dap.configurations.rust = {
  {
    type = "rust",
    request = "launch",
    name = "Rust: Launch",
    program = "${workspaceFolder}/target/debug/${workspaceFolderBasename}",
    cargo = {
      args = { "build", "--bin=${workspaceFolderBasename}" },
    },
    runAs = "build",
    cwd = "${workspaceFolder}",
    env = {},
  },
}

-- C/C++ DAP configuration
-- Launch mode runs a.out in the project root.
-- CMake variant prompts for the executable path (for out-of-source builds).
-- stopAtEntry = true pauses at main() so you can set breakpoints before running.
-- C++ shares the same configs as C (dap.configurations.cpp = dap.configurations.c).
dap.configurations.c = {
  {
    type = "cpp",
    request = "launch",
    name = "C: Launch",
    program = "${workspaceFolder}/a.out",
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
  },
  {
    type = "cpp",
    request = "launch",
    name = "C: Launch (cmake)",
    program = function()
      return vim.fn.input("Path to executable: ", "${workspaceFolder}/build/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
  },
}

-- C++ shares C config
dap.configurations.cpp = dap.configurations.c

-- Java DAP configuration
-- NOTE: nvim-jdtls provides enhanced Java debugging via jdtls.setup_dap().
-- These basic configs serve as a fallback. When nvim-jdtls is active,
-- it overrides these with richer configurations (test methods, class attach, etc.).
-- Keymaps for Java debugging are in plugins/config/jdtls.lua (<leader>dj, <leader>dJ).
dap.configurations.java = {
  {
    type = "java",
    request = "launch",
    name = "Java: Launch current class",
    mainClass = "${fileBasenameNoExtension}",
    classPaths = { "${workspaceFolder}/target/classes" },
    cwd = "${workspaceFolder}",
    consoleKind = "integratedTerminal",
  },
  {
    type = "java",
    request = "launch",
    name = "Java: Launch with main class",
    mainClass = function()
      return vim.fn.input("Main class (FQN): ", "", "file")
    end,
    classPaths = { "${workspaceFolder}/target/classes" },
    cwd = "${workspaceFolder}",
    consoleKind = "integratedTerminal",
  },
  {
    type = "java",
    request = "attach",
    name = "Java: Attach to JVM (port 5005)",
    hostName = "localhost",
    port = 5005,
  },
}

-- DAP UI setup
-- Layout: left sidebar shows scopes/breakpoints/stacks/watches (40 cols),
-- bottom panel shows REPL and console (10 rows).
-- Custom icons use Nerd Font glyphs for a cleaner look.
dapui.setup {
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  element_mappings = {},
  expand_lines = true,
  force_buffers = true,
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      position = "left",
      size = 40,
    },
    {
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      position = "bottom",
      size = 10,
    },
  },
  controls = {
    enabled = true,
    display = {
      position = "top",
    },
    element = "repl",
    icons = {
      disconnect = "󰑞",
      pause = "󰏯",
      play = "󰐌",
      run_last = "󰑡",
      step_back = "󰏪",
      step_into = "󰑫",
      step_out = "󰑮",
      step_over = "󰑰",
      terminate = "󰑦",
    },
  },
}

-- Auto open/close DAP UI on debug session lifecycle
-- This ensures the UI is visible when debugging starts and hidden when it ends,
-- so you don't have to manually toggle it each time.
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Load Telescope DAP extension
pcall(function()
  require("telescope").load_extension("dap")
end)

-- DAP keymaps
local keymap = vim.keymap.set

keymap("n", "<leader>dc", function() require("dap").continue() end, { desc = "DAP: Continue" })
keymap("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "DAP: Toggle Breakpoint" })
keymap("n", "<leader>dsi", function() require("dap").step_into() end, { desc = "DAP: Step Into" })
keymap("n", "<leader>dss", function() require("dap").step_over() end, { desc = "DAP: Step Over" })
keymap("n", "<leader>dso", function() require("dap").step_out() end, { desc = "DAP: Step Out" })
keymap("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "DAP: REPL" })
keymap("n", "<leader>dl", function() require("dap").run_last() end, { desc = "DAP: Run Last" })
keymap("n", "<leader>dt", function() require("dap").terminate() end, { desc = "DAP: Terminate" })
