return {
  require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = false,
    no_italic = true,
    integrations = {
      treesitter = true,
      blink_cmp = true,
      gitsigns = true,
      which_key = true,
      indent_blankline = { enabled = true, scope_color = "lavender" },
      native_lsp = {
        enabled = true,
        underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
        },
      },
    },
    highlight_overrides = {
      mocha = function(c)
        return {
          --------------------------------------------------------------------------
          -- UI
          --------------------------------------------------------------------------

          -- Diagonostics
          DiagnosticUnderlineError = { undercurl = true, sp = c.red },
          DiagnosticUnderlineWarn  = { undercurl = true, sp = c.peach },
          DiagnosticUnderlineInfo  = { undercurl = true, sp = c.blue },
          DiagnosticUnderlineHint  = { undercurl = true, sp = c.teal },

          --------------------------------------------------------------------------
          -- Treesitter
          --------------------------------------------------------------------------

          -- Types
          ["@type"]               = { fg = c.yellow },
          ["@type.builtin"]       = { fg = c.yellow },
          ["@type.definition"]    = { fg = c.mauve },
          ["@constructor"]        = { fg = c.yellow },

          -- Functions
          ["@function"]           = { fg = c.blue },
          ["@function.call"]      = { fg = c.blue },
          ["@function.method"]    = { fg = c.blue },
          ["@function.method.call"] = { fg = c.blue },

          -- Variables
          ["@variable"]           = { fg = c.text },
          ["@variable.parameter"] = { fg = c.maroon },
          ["@variable.member"]    = { fg = c.text },
          ["@property"]           = { fg = c.text },

          -- Constants
          ["@constant"]           = { fg = c.peach },
          ["@constant.builtin"]   = { fg = c.peach },
          ["@constant.macro"]     = { fg = c.peach },
          ["@constant.enum"]      = { fg = c.green },

          -- Macros
          ["@function.macro"]     = { fg = c.peach },

          -- Keywords
          ["@keyword"]            = { fg = c.mauve },
          ["@keyword.type"]       = { fg = c.mauve },
          ["@keyword.return"]     = { fg = c.mauve },
          ["@keyword.operator"]   = { fg = c.mauve },

          --------------------------------------------------------------------------
          -- clangd semantic tokens (C/C++)
          --------------------------------------------------------------------------

          -- Types
          ["@lsp.type.class.cpp"]     = { fg = c.yellow },
          ["@lsp.type.struct.cpp"]    = { fg = c.yellow },
          ["@lsp.type.enum.cpp"]      = { fg = c.yellow },
          ["@lsp.type.union.cpp"]     = { fg = c.yellow },
          ["@lsp.type.type.cpp"]      = { fg = c.yellow },
          ["@lsp.type.typedef.cpp"]   = { fg = c.mauve },

          ["@lsp.type.class.c"]       = { fg = c.yellow },
          ["@lsp.type.struct.c"]      = { fg = c.yellow },
          ["@lsp.type.enum.c"]        = { fg = c.yellow },
          ["@lsp.type.type.c"]        = { fg = c.yellow },
          ["@lsp.type.typedef.c"]     = { fg = c.mauve },

          -- Functions
          ["@lsp.type.function.cpp"]  = { fg = c.blue },
          ["@lsp.type.method.cpp"]    = { fg = c.blue },
          ["@lsp.type.function.c"]    = { fg = c.blue },

          -- Variables
          ["@lsp.type.variable.cpp"]  = { fg = c.text },
          ["@lsp.type.variable.c"]    = { fg = c.text },
          ["@lsp.type.parameter.cpp"] = { fg = c.maroon },
          ["@lsp.type.parameter.c"]   = { fg = c.maroon },

          -- Fields
          ["@lsp.type.property.cpp"]  = { fg = c.text },
          ["@lsp.type.property.c"]    = { fg = c.text },

          -- Enums
          ["@lsp.type.enumMember.cpp"] = { fg = c.green },
          ["@lsp.type.enumMember.c"]   = { fg = c.green },

          -- Macros
          ["@lsp.type.macro.cpp"]     = { fg = c.peach },
          ["@lsp.type.macro.c"]       = { fg = c.peach },

          --------------------------------------------------------------------------
          -- clangd modifiers
          --------------------------------------------------------------------------

          ["@lsp.typemod.variable.readonly.cpp"] = {
            fg = c.blue,
            bold = true,
          },

          ["@lsp.typemod.variable.readonly.c"] = {
            fg = c.blue,
            bold = true,
          },

          ["@lsp.typemod.variable.global.cpp"] = {
            fg = c.maroon,
          },

          ["@lsp.typemod.variable.global.c"] = {
            fg = c.maroon,
          },

          ["@lsp.typemod.property.static.cpp"] = {
            fg = c.teal,
          },

          ["@lsp.typemod.property.static.c"] = {
            fg = c.teal,
          },
        }
      end,
    },
  }),
  vim.cmd.colorscheme("catppuccin")
}
