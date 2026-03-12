local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

local create_cmd = vim.api.nvim_create_user_command

create_cmd("TSInstallAll", function()
  local spec = require("lazy.core.config").plugins["nvim-treesitter"]
  local opts = type(spec.opts) == "table" and spec.opts or {}
  require("nvim-treesitter").install(opts.ensure_installed)
end, {})
