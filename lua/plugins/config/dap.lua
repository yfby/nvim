-- DAP (Debug Adapter Protocol) configuration
local dap = require("dap")
local dapui = require("dapui")

-- Python DAP setup (using nvim-dap-python)
pcall(function()
  require("dap-python").setup("python")
end)

-- Python DAP configuration
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

-- DAP UI setup
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

-- Auto open UI when debugging starts
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
