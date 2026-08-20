local colorful_menu = require("colorful-menu")
local highlight_colors = require("nvim-highlight-colors")

-------------------------------------------------------------------------------
-- colorful-menu helpers
-------------------------------------------------------------------------------

local function label_text(ctx)
  local ok, text = pcall(colorful_menu.blink_components_text, ctx)

  if ok and text then
    return text
  end

  return ctx.label
end
local function label_highlights(ctx)
  local highlights

  local ok, result = pcall(colorful_menu.blink_highlights, ctx)

  if ok and result then
    highlights = result.highlights
  end

  if not highlights then
    highlights = {
      { 0, #ctx.label, group = "BlinkCmpLabel" },
    }
  end
  -- restore fuzzy match highlights
  for _, idx in ipairs(ctx.label_matched_indices) do
    table.insert(highlights, {
      idx,
      idx + 1,
      group = "BlinkCmpLabelMatch",
    })
  end

  return highlights
end

-------------------------------------------------------------------------------
-- color helpers
-------------------------------------------------------------------------------

local function color_item(ctx)
  if ctx.item.source_name ~= "LSP" then
    return nil
  end

  return highlight_colors.format(
    ctx.item.documentation,
    { kind = ctx.kind }
  )
end
local function kind_icon_text(ctx)
  local icon = ctx.kind_icon
  local color = color_item(ctx)

  if color and color.abbr ~= "" then
    icon = color.abbr
  end

  return icon .. ctx.icon_gap
end
local function kind_icon_highlight(ctx)
  local color = color_item(ctx)

  if color and color.abbr_hl_group then
    return color.abbr_hl_group
  end

  return "BlinkCmpKind" .. ctx.kind
end

-------------------------------------------------------------------------------
-- blink config
-------------------------------------------------------------------------------

return {
  keymap = {
    preset = "default",
    ["<Tab>"] = {
      "select_next",
      "fallback",
    },
    ["<S-Tab>"] = {
      "select_prev",
      "fallback",
    },
    ["<CR>"] = {
      "accept",
      "fallback",
    },
  },

  appearance = {
    nerd_font_variant = "mono",
  },

  completion = {
    ghost_text = {
      enabled = false,
      show_with_menu = true,
    },

    list = {
      selection = {
        preselect = true,
        auto_insert = true,
      },
    },
    documentation = {
      auto_show = true,

      window = {
        border = "single",
      },
    },
    menu = {
      border = "single",
      draw = {
        columns = {
          { "kind_icon", gap = 1 },
          { "label", gap = 1 },
        },
        components = {
          label = {
            text = label_text,
            highlight = label_highlights,
          },
          kind_icon = {
            text = kind_icon_text,
            highlight = kind_icon_highlight,
          },
        },
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer", },
    providers = {
      lsp = {
        name = 'LSP',
        enabled = true,
        module = 'blink.cmp.sources.lsp',
        score_offset = 1000,
      }
    }
  },
  fuzzy = {
    implementation = "prefer_rust",
    sorts = {
      "exact",
      "score",
      "sort_text",
    },
  },
}
