-- Enhanced Telescope configuration
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_ignore_patterns = { "node_modules", ".git", "build", "dist", "vendor" },
    path_display = { "truncate" },
    winblend = 0,
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<esc>"] = actions.close,
      },
      n = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["q"] = actions.close,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      show_hidden = true,
    },
    live_grep = {
      additional_args = function()
        return { "--hidden" }
      end,
    },
    grep_string = {
      additional_args = function()
        return { "--hidden" }
      end,
    },
    buffers = {
      initial_mode = "normal",
      mappings = {
        n = {
          ["d"] = actions.delete_buffer,
        },
      },
    },
    colorscheme = {
      enable_preview = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      case_mode = "smart_case",
    },
  },
}

pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "projects")
pcall(telescope.load_extension, "dap")
