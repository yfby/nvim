--- Safe module loader to prevent startup failures
-- Returns nil on error and notifies user
local M = {}

function M.safe_require(module_name)
  local ok, result = pcall(require, module_name)
  if not ok then
    vim.notify(
      string.format("Failed to load module '%s':\n%s", module_name, tostring(result)),
      vim.log.levels.ERROR,
      { title = "Config Loader Error" }
    )
    return nil
  end
  return result
end

return M
