local opt = vim.opt
local g = vim.g

-------------------------------------------------------------------------------
-- general config
-------------------------------------------------------------------------------
g.mapleader = " "

-- System Clipboard
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

opt.undofile = true
opt.timeoutlen = 400
opt.whichwrap:append "<>[]hl"

-- Add Mason binaries to system PATH
local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
local mason_path = vim.fn.stdpath("data") .. sep .. "mason" .. sep .. "bin"
vim.env.PATH = mason_path .. delim .. vim.env.PATH

-------------------------------------------------------------------------------
-- ui & appearance
-------------------------------------------------------------------------------
opt.termguicolors = true
opt.laststatus = 3
opt.showmode = false
opt.signcolumn = "yes"
opt.cursorline = true
opt.cursorlineopt = "number,line"
opt.ruler = false

-- Line Numbers
opt.number = true
opt.numberwidth = 2

-- Splits
opt.splitbelow = true
opt.splitright = true

opt.fillchars = { eob = " " }

-------------------------------------------------------------------------------
-- indentation & wrapping
-------------------------------------------------------------------------------
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.wrap = false

-------------------------------------------------------------------------------
-- searching
-------------------------------------------------------------------------------
opt.ignorecase = true
opt.smartcase = true

-------------------------------------------------------------------------------
-- autocommands
-------------------------------------------------------------------------------
-- Highlight text on yank (copy)
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
