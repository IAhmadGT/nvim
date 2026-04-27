local map = vim.keymap.set

-------------------------------------------------------------------------------
-- general mappings
-------------------------------------------------------------------------------
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy whole file" })

-- Toggles
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })

-- Insert mode navigation
map("i", "<C-b>", "<ESC>^i", { desc = "Move to beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move to end of line" })
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

-------------------------------------------------------------------------------
-- navigation & buffers
-------------------------------------------------------------------------------
-- Yazi
map("n", "<leader>v", "<cmd>Yazi<cr>", { desc = "Yazi (File Explorer)" })

-- Buffer Management
map("n", "<leader>]", "<cmd>bn<cr>", { desc = "Next buffer" })
map("n", "<leader>[", "<cmd>bp<cr>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Close current buffer" })

-- Comments (Uses Neovim 0.10+ builtin gc/gcc)
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-------------------------------------------------------------------------------
-- telescope
-------------------------------------------------------------------------------
-- Standard Search
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "Find all files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Find in current buffer" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Find oldfiles" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Find marks" })

-- Git
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Git status" })

-- Misc
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help page" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "Pick hidden terminal" })

-------------------------------------------------------------------------------
-- custom config searches (telescope)
-------------------------------------------------------------------------------

-- Neovim Config
map("n", "<leader>fp", function()
  require("telescope.builtin").find_files({
    cwd = vim.fn.stdpath("config"),
    prompt_title = "Neovim Config",
  })
end, { desc = "Search Neovim config" })

map("n", "<leader>fsp", function()
  require("telescope.builtin").live_grep({
    cwd = vim.fn.stdpath("config"),
    prompt_title = "Grep Neovim Config",
  })
end, { desc = "Grep in Neovim config" })

-- NixOS Config
-- map("n", "<leader>fn", function()
--   require("telescope.builtin").find_files({
--     cwd = "~/nixos/",
--     prompt_title = "NixOS Config",
--   })
-- end, { desc = "Search NixOS config" })
