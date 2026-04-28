return
{
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
  ensure_installed = {
    "vim",
    "vimdoc",
    "c",
    "cpp",
    "html",
    "css",
    "json",
    "lua",
    "markdown",
    "python",
    "bash",
    "nix"
  },
}
