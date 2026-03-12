-- Based on: { 
--    Eviline config for lualine
-- }
local lualine = require('lualine')

-- Catpuccine Color Palette
local colors = {
  bg       = '#181825',  -- Background
  fg       = '#D9E0EE',  -- Foreground

  blue     = '#89b4fa',  -- Blue
  cyan     = '#A7D8D3',  -- Cyan
  green    = '#a6e3a1',  -- Green
  violet   = '#CBA6F7',  -- Violet
  magenta  = '#F5A97F',  -- Magenta
  red      = '#f38ba8',  -- Red
  yellow   = '#f9e2af',  -- Yellow
  orange   = '#fab387',  -- Orange

  darkblue = '#24283B',  -- Darker Blue for accents
  white    = '#D9E0EE',  -- White
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
}

local config = {
  options = {
    component_separators = '',
    section_separators = '',
    theme = {
      normal   = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- Left accent bar
ins_left {
  function() return '▊' end,
  color = { fg = colors.bg },
  padding = { left = 0, right = 0 },
}

-- Mode
ins_left {
  'mode',
  color = function()
    local mode_color = {
      n  = colors.blue,
      i  = colors.green,
      v  = colors.violet,
      [''] = colors.violet,
      V  = colors.violet,
      c  = colors.magenta,
      R  = colors.red,
      r  = colors.orange,
      t  = colors.red,
    }

    local m = vim.fn.mode()
    local col = mode_color[m] or colors.blue

    return {
      fg = colors.bg,   -- text becomes dark
      bg = col,         -- mode color becomes background
      gui = 'bold',
    }
  end,
  padding = { left = 1, right = 1 },
}

-- Filename 
ins_left {
  function()
    local filename = vim.fn.expand('%:t')
    if filename == '' then
      return ''
    end
    local icon = require('nvim-web-devicons')
      .get_icon(filename, nil, { default = true })
    return string.format(' %s %s', icon or '', filename)
  end,
  cond = conditions.buffer_not_empty,
  color = function()
    local filename = vim.fn.expand('%:t')
    local devicons = require('nvim-web-devicons')
    local _, icon_color = devicons.get_icon_color(filename, nil, { default = true })

    -- If modified, override colour
    if vim.bo.modified then
      return { fg = colors.yellow, gui = 'bold' }
    end

    -- Otherwise use icon color
    return { fg = icon_color or colors.white, gui = 'bold' }
  end,
  padding = { right = 1 },
}

-- Git branch
ins_left {
  'branch',
  icon = '',
  color = { fg = colors.cyan, gui = 'bold' },
}

-- Git diff
ins_left {
  'diff',
  symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
  diff_color = {
    added    = { fg = colors.green },
    modified = { fg = colors.orange },
    removed  = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  'searchcount',
  color = { fg = colors.white, gui = 'bold' },
}

ins_right {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    error = { fg = colors.red },
    warn  = { fg = colors.yellow },
    info  = { fg = colors.cyan },
  },
}

-- LSP
ins_right {
  function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
      return ''
    end

    if vim.fn.winwidth(0) < 80 then
      return ' '
    end

    local names = {}
    for _, client in ipairs(clients) do
      table.insert(names, client.name)
    end
    return table.concat(names, ', ')
  end,
  icon = '',
  color = { fg = colors.green, gui = 'bold' },
  padding = { left = 0, right = 0 },
}

-- Location
ins_right {
  function()
    local line = vim.fn.line('.')
    local col = vim.fn.virtcol('.')
    return string.format('Ln %d, Col %d ', line, col)
  end,
  color = { fg = colors.cyan },
  padding = { left = 1, right = 0 },
}

-- Encoding
ins_right {
  'o:encoding',
  fmt = string.upper,
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  function()
    return vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':t')
  end,
  icon = '󰉋 ',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.bg, bg = colors.blue, gui = 'bold' },
  padding = { left = 1, right = 1 },
}

lualine.setup(config)
