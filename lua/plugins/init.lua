return {
  -----------------------------------------------------------------------------
  -- ui
  -----------------------------------------------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        return require "configs.catppuccin"
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
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {},
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
    lazy = true,
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
    event = "InsertEnter",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
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
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    'Civitasv/cmake-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'stevearc/overseer.nvim' },
    cmd = {
      "CMakeGenerate",
      "CMakeBuild",
      "CMakeRun",
      "CMakeDebug",
      "CMakeClean",
      "CMakeSelectBuildType",
      "CMakeSelectKit",
    },
    opts = {
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_directory = "build",
      cmake_executor = {
        name = "quickfix",
        opts = {}
      },
      cmake_runner = {
        name = "quickfix",
        opts = {},
      },
    },
    keys = {
      { "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "CMake Generate" },
      { "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake Build" },
      { "<leader>cr", "<cmd>CMakeRun<cr>", desc = "CMake Run" },
      { "<leader>cd", "<cmd>CMakeDebug<cr>", desc = "CMake Debug (DAP)" },
      { "<leader>ck", "<cmd>CMakeSelectKit<cr>", desc = "CMake Select Kit" },
      { "<leader>ct", "<cmd>CMakeSelectBuildType<cr>", desc = "CMake Select Build Type" },
    }
  },
  {
    'stevearc/overseer.nvim',
    lazy = false,
    opts = {
      task_list = {
      },
    },
  },
  {
    'stevearc/quicker.nvim',
    ft = "qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
      buflisted = false,
      wrap = true,
      number = false,
    },
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {}
  },
  {
    "kylechui/nvim-surround",
    -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
    -- config = function()
    --     require("nvim-surround").setup({
    --         -- Put your configuration here
    --     })
    -- end
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
    event = { "BufReadPre", "BufNewFile" },
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
    keys = {
      {
        "<leader>dd",
        function() require("debugmaster").mode.toggle() end,
        mode = { "n", "v" },
        nowait = true,
        desc = "Run Debugger"
      },
    },
    config = function()
      local dm = require("debugmaster")
      vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
      dm.plugins.osv_integration.enabled = true
    end,
  }
}
