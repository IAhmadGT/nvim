return {
    keymap = {
      preset = 'default',
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },

    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      ghost_text = {
        enabled = true,
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
        window = { border = 'single' },
      },
      menu = {
        border = 'single',
        draw = {
          columns = { { 'kind_icon', gap = 1 }, { 'label', gap = 1 } },
          components = {
            -- 1. Use colorful-menu for the main label
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                local highlights = require("colorful-menu").blink_highlights(ctx)
                if highlights == nil then
                  -- Fallback if colorful-menu doesn't have data
                  highlights = { { 0, #ctx.label, group = "BlinkCmpLabel" } }
                else
                  highlights = highlights.highlights
                end

                -- Re-insert fuzzy match highlights because we are overriding the highlight function
                for _, idx in ipairs(ctx.label_matched_indices) do
                  table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                end

                return highlights
              end,
            },

            -- 2. Use nvim-highlight-colors for the icon (color swatches)
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if ctx.item.source_name == "LSP" then
                  local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr ~= "" then
                    icon = color_item.abbr
                  end
                end
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local highlight = "BlinkCmpKind" .. ctx.kind
                if ctx.item.source_name == "LSP" then
                  local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr_hl_group then
                    highlight = color_item.abbr_hl_group
                  end
                end
                return highlight
              end,
            },
          },
        },
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = {
      implementation = "prefer_rust_with_warning",
      sorts = { 'exact', 'score', 'sort_text' },
    },
}
