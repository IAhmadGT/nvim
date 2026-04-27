-------------------------------------------------------------------------------
-- diagnostics & ui
-------------------------------------------------------------------------------
local diagnostic_signs = {
  Error = " ",
  Warn  = " ",
  Hint  = "",
  Info  = "",
}

vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
      [vim.diagnostic.severity.WARN]  = diagnostic_signs.Warn,
      [vim.diagnostic.severity.INFO]  = diagnostic_signs.Info,
      [vim.diagnostic.severity.HINT]  = diagnostic_signs.Hint,
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    focusable = false,
    style = "minimal",
  },
})

-- Global hover/signature border override
local orig_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_floating_preview(contents, syntax, opts, ...)
end

-------------------------------------------------------------------------------
-- lsp keymaps (on_attach)
-------------------------------------------------------------------------------
local function lsp_on_attach(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  local bufnr = ev.buf
  local opts = { noremap = true, silent = true, buffer = bufnr }

  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
  end

  -- Navigation
  map("n", "<leader>gd", function() require("fzf-lua").lsp_definitions({ jump1 = true }) end, "Fzf Definition")
  map("n", "<leader>gD", vim.lsp.buf.definition, "LSP Definition")
  map("n", "<leader>gS", function() vim.cmd("vsplit"); vim.lsp.buf.definition() end, "Split Definition")
  map("n", "K", vim.lsp.buf.hover, "Hover Documentation")

  -- Actions
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("n", "<leader>rn", vim.lsp.buf.rename, "LSP Rename")

  -- Diagnostics (Buffer local)
  map("n", "<leader>D",  function() vim.diagnostic.open_float({ scope = "line" }) end, "Line Diagnostics")
  map("n", "<leader>d",  function() vim.diagnostic.open_float({ scope = "cursor" }) end, "Cursor Diagnostics")
  map("n", "<leader>nd", function() vim.diagnostic.jump({ count = 1 }) end, "Next Diagnostic")
  map("n", "<leader>pd", function() vim.diagnostic.jump({ count = -1 }) end, "Prev Diagnostic")

  -- Organize Imports (if supported)
  if client and client:supports_method("textDocument/codeAction") then
    map("n", "<leader>oi", function()
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" }, diagnostics = {} },
        apply = true,
      })
      vim.defer_fn(function() vim.lsp.buf.format({ bufnr = bufnr }) end, 50)
    end, "Organize Imports & Format")
  end
end

-- Global Diagnostic Mappings
vim.keymap.set("n", "<leader>q", function() vim.diagnostic.setloclist({ open = true }) end, { desc = "Diagnostic List" })

-- Register the attach function
vim.api.nvim_create_autocmd("LspAttach", { callback = lsp_on_attach })

-------------------------------------------------------------------------------
-- server configurations
-------------------------------------------------------------------------------
-- Default capabilities from blink.cmp
vim.lsp.config["*"] = {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
}

-- Lua
vim.lsp.config.lua_ls = {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      telemetry = { enable = false },
    },
  },
}

-- C / C++
vim.lsp.config.clangd = {
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  cmd = {
    "clangd",
    "--compile-commands-dir=build",
    "--all-scopes-completion",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--limit-results=70",
    "--pch-storage=disk",
    "--log=error",
    "--suggest-missing-includes",
  },
}

-- Typst
vim.lsp.config.tinymist = {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  settings = {},
}

-- Assembly
vim.lsp.config["asm-lsp"] = {
  cmd = { "asm-lsp" },
  filetypes = { "asm", "vmasm" },
  root_markers = { ".git" },
}

-- QML
vim.lsp.config.qmlls = {
  cmd = { "qmlls", "-E" },
  filetypes = { "qml", "qmljs" },
}

-- CMake 
vim.lsp.config.neocmake = {
  cmd = { "neocmakelsp", "stdio" },
  filetypes = { "cmake" },
  root_dir = require("lspconfig.util").root_pattern(
    "CMakeLists.txt",
    ".git"
  ),
}

local servers = {
  "bashls",
  "cssls",
  "neocmake",
  "nixd",
  "basedpyright"
}

for _, lsp in ipairs(servers) do
  local default_config = require('lspconfig.configs.' .. lsp).default_config
  vim.lsp.config[lsp] = vim.tbl_deep_extend("force", default_config, vim.lsp.config[lsp] or {})
end

-- Enable all configured servers
vim.lsp.enable({
  "lua_ls",
  "bashls",
  "clangd",
  "cssls",
  "neocmake",
  "nixd",
  "qmlls",
  "tinymist",
  "basedpyright",
  "asm-lsp"
})
