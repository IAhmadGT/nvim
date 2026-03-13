-- Based on: { 
--    Eviline config for lualine
-- }
local lualine = require('lualine')

-- Catppuccin Mocha Palette
local colors = {
  bg       = '#181825',
  fg       = '#D9E0EE',
  blue     = '#89b4fa',
  cyan     = '#A7D8D3',
  green    = '#a6e3a1',
  violet   = '#CBA6F7',
  magenta  = '#F5A97F',
  red      = '#f38ba8',
  yellow   = '#f9e2af',
  orange   = '#fab387',
  darkblue = '#24283B',
  white    = '#D9E0EE',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
}

-- Debug Mode State
local dmode_enabled = false
vim.api.nvim_create_autocmd("User", {
  pattern = "DebugModeChanged",
  callback = function(args)
    dmode_enabled = args.data.enabled
  end
})

local config = {
  options = {
    component_separators = '',
    section_separators = '',
    theme = {
      normal   = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
    globalstatus = true,
  },
  sections = {
    lualine_a = {}, lualine_b = {}, lualine_y = {},
    lualine_z = {}, lualine_c = {}, lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {}, lualine_b = {}, lualine_y = {},
    lualine_z = {}, lualine_c = {}, lualine_x = {},
  },
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-------------------------------------------------------------------------------
-- left side
-------------------------------------------------------------------------------

-- Decorative Bar
ins_left {
  function() return '▊' end,
  color = { fg = colors.blue },
  padding = { left = 0, right = 1 },
}

-- Mode Component
ins_left {
  function()
    return dmode_enabled and "DEBUG" or require('lualine.utils.mode').get_mode()
  end,
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
    return {
      bg = dmode_enabled and colors.red or mode_color[vim.fn.mode()] or colors.blue,
      fg = colors.bg,
      gui = 'bold',
    }
  end,
  padding = { left = 1, right = 1 },
}

-- Filename with Icon
ins_left {
  function()
    local filename = vim.fn.expand('%:t')
    if filename == '' then return '' end
    local icon, _ = require('nvim-web-devicons').get_icon(filename, nil, { default = true })
    return icon .. ' ' .. filename
  end,
  cond = conditions.buffer_not_empty,
  color = function()
    if vim.bo.modified then
      return { fg = colors.yellow, gui = 'bold' }
    end
    local _, icon_color = require('nvim-web-devicons').get_icon_color(vim.fn.expand('%:t'), nil, { default = true })
    return { fg = icon_color or colors.white, gui = 'bold' }
  end,
}

-- Git info
ins_left {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

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

-------------------------------------------------------------------------------
-- right side
-------------------------------------------------------------------------------

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

-- LSP Clients
ins_right {
  function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then return '' end
    if vim.fn.winwidth(0) < 80 then return ' ' end
    local names = {}
    for _, client in ipairs(clients) do
      table.insert(names, client.name)
    end
    return table.concat(names, '|')
  end,
  icon = '',
  color = { fg = colors.white, gui = 'bold' },
}

-- Location
ins_right {
  function()
    return string.format('Ln %d, Col %d', vim.fn.line('.'), vim.fn.virtcol('.'))
  end,
  color = { fg = colors.white },
}

-- Working Directory
ins_right {
  function()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
  end,
  icon = '󰉋',
  color = { bg = colors.blue, fg = colors.bg, gui = 'bold' },
  padding = { left = 1, right = 1 },
}

lualine.setup(config)
