return {
  -----------------------------------------------------------------------------
  -- ui
  -----------------------------------------------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
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
          native_lsp = { enabled = true },
        },
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
        local dashboard = require('configs.dashboard')
        require("alpha").setup(dashboard.config)
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return require "configs.lualine"
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { char = "│", show_start = false },
    },
  },

  -----------------------------------------------------------------------------
  -- navigation & search
  -----------------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "configs.telescope"
    end,
  },
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      open_for_directories = true,
      keymaps = { show_help = "<f1>" },
    },
    init = function()
      vim.g.loaded_netrwPlugin = 1
    end,
  },

  -----------------------------------------------------------------------------
  -- lsp, completion & formatting
  -----------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = function()
      return require "configs.mason"
    end,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = {
      "xzbdmw/colorful-menu.nvim",
      "brenoprata10/nvim-highlight-colors",
    },
    opts = function()
      return require "configs.blinkcmp"
    end,
  },
  {
    "xzbdmw/colorful-menu.nvim",
    config = function()
      require("colorful-menu").setup({
        ls = {
          lua_ls = { arguments_hl = "@comment" },
          clangd = {
            extra_info_hl = "@comment",
            align_type_to_right = true,
            import_dot_hl = "@comment",
            preserve_type_when_truncate = true,
          },
          basedpyright = { extra_info_hl = "@comment" },
          pylsp = { extra_info_hl = "@comment", arguments_hl = "@comment" },
          fallback = true,
          fallback_extra_info_hl = "@comment",
        },
        fallback_highlight = "@variable",
        max_width = 60,
      })
    end,
  },

  -----------------------------------------------------------------------------
  -- coding & editor utils
  -----------------------------------------------------------------------------
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPost",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "virtual",
        virtual_symbol = "",
        virtual_symbol_position = "inline",
      })
    end,
  },
  {
    'stevearc/overseer.nvim',
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    cmd = { "OverseerRun", "OverseerToggle" },
    opts = {},
  },

  -----------------------------------------------------------------------------
  -- git
  -----------------------------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      return require "configs.gitsigns"
    end,
  },

  -----------------------------------------------------------------------------
  -- treesitter & language specific
  -----------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "configs.treesitter"
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown" },
    dependencies = { "saghen/blink.cmp" },
    opts = {
      preview = { icon_provider = "devicons" },
    },
  },
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    opts = {},
  },

  -----------------------------------------------------------------------------
  -- debugger (dap)
  -----------------------------------------------------------------------------
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      ensure_installed = { "codelldb" },
      automatic_setup = true,
    },
  },
  {
    "mfussenegger/nvim-dap",
    cmd = {
      "DapContinue",
      "DapToggleBreakpoint",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
    },
    -- keys = {
    --   { "<leader>b", "<cmd>DapToggleBreakpoint<CR>", desc = "Debugger Breakpoint" },
    --   { "<leader>dr", "<cmd>DapContinue<CR>", desc = "Run Debugger" },
    -- },
    config = function()
      local dap = require("dap")
      local fn = vim.fn

      local is_termux = os.getenv("TERMUX_VERSION") ~= nil
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"

      local cmd = (is_termux or vim.fn.executable(mason_path) == 0) and "codelldb" or mason_path

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = cmd,
          args = { "--port", "${port}" },
        },
      }

      local cpp_config = {
        {
          name = "Launch executable (CodeLLDB)",
          type = "codelldb",
          request = "launch",
          program = function()
            return fn.input("Path to executable: ", fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.cpp = cpp_config
      dap.configurations.c = cpp_config

      local signs = {
        DapBreakpoint = " ",
        DapBreakpointCondition = " ",
        DapBreakpointRejected = " ",
        DapLogPoint = " ",
        DapStopped = " ",
      }
      for name, text in pairs(signs) do
        fn.sign_define(name, { text = text, texthl = name })
      end
    end,
  },
  {
    "MironPascalCaseFan/debugmaster.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dm = require("debugmaster")
      vim.keymap.set({ "n", "v" }, "<leader>dd", dm.mode.toggle, { nowait = true }, {desc = "Run Debugger"})
      vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
      dm.plugins.osv_integration.enabled = true
    end,
  }
}
