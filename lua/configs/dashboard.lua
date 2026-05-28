local if_nil = vim.F.if_nil

vim.api.nvim_set_hl(0, "AlphaLineOrange", { fg = "#ff9e64" })
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "AlphaLineOrange", { fg = "#ff9e64" })
    end,
})

local default_header = {
    type = "text",
    val = {
        [[                                                                   ]],
        [[ ██████   █████                                ███                 ]],
        [[░░██████ ░░███                                ░░░                  ]],
        [[░███░███ ░███   ██████   ██████  █████ █████ ████  █████████████   ]],
        [[░███░░███░███  ███░░███ ███░░███░░███ ░░███ ░░███ ░░███░░███░░███  ]],
        [[░███ ░░██████ ░███████ ░███ ░███ ░███  ░███  ░███  ░███ ░███ ░███  ]],
        [[░███  ░░█████ ░███░░░  ░███ ░███ ░░███ ███   ░███  ░███ ░███ ░███  ]],
        [[█████  ░░█████░░██████ ░░██████   ░░█████    █████ █████░███ █████ ]],
        [[░░░░░    ░░░░░  ░░░░░░   ░░░░░░     ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░ ]],
        [[                                                                   ]],
        [[                                                                   ]],
    },
    opts = {
        position = "center",
        hl = "Function",
    },
}

local line = {
    type = "text",
    val = "──────────────────────────────────────────────────",
    opts = {
        position = "center",
        hl = "AlphaLineOrange",
    },
}

local footer = {
    type = "text",
    val = "Loading plugins...",
    opts = {
        position = "center",
        hl = "Number",
    },
}

vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime + 0.5)

        footer.val = "󰚥 " .. stats.count .. " plugins loaded in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
    end,
})

local leader = "SPC"

--- @param sc string
--- @param txt string
--- @param keybind string|function? optional
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 3,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
    }
    if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        -- If keybind is a function, call it. If it's a string, feed it.
        if type(keybind) == "function" then
            keybind()
        else
            local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
            vim.api.nvim_feedkeys(key, "t", false)
        end
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local buttons = {
    type = "group",
    val = {
        button("SPC f f", "  Find file",         "<cmd>Telescope find_files<CR>"),
        button("SPC f o", "󰈚  Recent files",       "<cmd>Telescope oldfiles<CR>"),
        button("SPC f w", "  Find word (Grep)",   "<cmd>Telescope live_grep<CR>"),
        button("SPC f a", "󰈈  Find all files",     "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>"),
        button("e",       "  New file",          "<cmd>ene <CR>"),
        button("SPC m a", "  Jump to bookmarks",   "<cmd>Telescope marks<CR>"),
        button("SPC f p", "  Neovim config", function()
            require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config"), prompt_title = "Neovim Config" })
        end),
    },
    opts = {
        spacing = 1,
    },
}

local section = {
    header = default_header,
    buttons = buttons,
    line = line,
    footer = footer,
}

local config = {
    layout = {
        { type = "padding", val = 2 },
        section.header,
        { type = "padding", val = 2 },
        section.buttons,
        { type = "padding", val = 1 },
        section.line,
        { type = "padding", val = 0 }, 
        section.footer,
        { type = "padding", val = 0 },
        section.line,
    },
    opts = {
        margin = 5,
    },
}

return {
    button = button,
    section = section,
    config = config,
    leader = leader,
    opts = config,
}
