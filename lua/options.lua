local opt = vim.opt
local api = vim.api
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

-- Enable undercurls
api.nvim_set_var('t_Cs', [['\e[4:3m']])
api.nvim_set_var('t_Ce', [['\e[4:0m']])

-- UI2
require('vim._core.ui2').enable({
  enable = true,
  msg = {
    targets = 'cmd',
    cmd = {
      height = 0.5
    },
    dialog = {
      height = 0.5,
    },
    msg = {
      height = 0.5,
      timeout = 4000,
    },
    pager = {
      height = 1,
    },
  },
})

-------------------------------------------------------------------------------
-- indentation & wrapping
-------------------------------------------------------------------------------

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 4
opt.softtabstop = 4
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

-- Highlight text on yank 
api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-------------------------------------------------------------------------------
-- filetypes
---------------------------------------------------------------------------------

vim.filetype.add({
  extension = {
    vert = 'glsl',
    tesc = 'glsl',
    tese = 'glsl',
    frag = 'glsl',
    geom = 'glsl',
    comp = 'glsl',
    razor = 'razor',
    qrc = 'xml',
  }
})
