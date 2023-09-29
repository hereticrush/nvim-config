local opts = { noremap = true, silent = true, buffer = nil, nowait = true }
-- Close all windows and exit from Neovim with <leader> and q
vim.keymap.set("n", "<leader>q", ":qa!<CR>", opts)
-- Fast saving with <leader> and s
vim.keymap.set("n", "<leader>s", ":w<CR>", opts)
-- Move around splits
vim.keymap.set("n", "<leader>wh", "<C-w>h", opts)
vim.keymap.set("n", "<leader>wj", "<C-w>j", opts)
vim.keymap.set("n", "<leader>wk", "<C-w>k", opts)
vim.keymap.set("n", "<leader>wl", "<C-w>l", opts)

-- Reload configuration without restart nvim
vim.keymap.set("n", "<leader>wo", ":so %<CR>", opts)

-- Telescope
-- <leader> is a space now
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)

-- NvimTree
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", opts)    -- open/close
vim.keymap.set("n", "<leader>nr", ":NvimTreeRefresh<CR>", opts)  -- refresh
vim.keymap.set("n", "<leader>nf", ":NvimTreeFindFile<CR>", opts) -- search file

-- Terminal
--vim.keymap.set("n", "<leader>tt", ":NeotermToggle<CR>", opts)
-- vim.keymap.set("n", "<leader>tx", ":NeotermExit<CR>", opts)
-- Which-key
vim.keymap.set("n", "<leader>W", ":WhichKey<CR>", opts)

-- Harpoon
vim.keymap.set("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>", opts)
vim.keymap.set("n", "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
vim.keymap.set("n", "<leader>hj", ":lua require('harpoon.ui').nav_prev<CR>", opts)
vim.keymap.set("n", "<leader>hk", ":lua require('harpoon.ui').nav_next()<CR>", opts)

-- Git
vim.keymap.set("n", "<leader>tt", ":lua _LAZYGIT_TOGGLE()<CR>", opts)
vim.keymap.set("n", "<leader>tj", ":lua require 'gitsigns'.next_hunk()<cr>", opts)
vim.keymap.set("n", "<leader>tk", ":lua require 'gitsigns'.prev_hunk()<cr>", opts)
vim.keymap.set("n", "<leader>tb", ":lua require 'gitsigns'.blame_line()<cr>", opts)
vim.keymap.set("n", "<leader>ts", ":lua require 'gitsigns'.stage_hunk()<cr>", opts)
vim.keymap.set("n", "<leader>tp", ":lua require 'gitsigns'.preview_hunk()<cr>", opts)
vim.keymap.set("n", "<leader>tu", ":lua require 'gitsigns'.undo_stage_hunk()<cr>", opts)
vim.keymap.set("n", "<leader>tr", ":lua require 'gitsigns'.reset_hunk()<cr>", opts)
vim.keymap.set("n", "<leader>tR", ":lua require 'gitsigns'.reset_buffer()<cr>", opts)
vim.keymap.set("n", "<leader>td", "<cmd>Gitsigns diffthis HEAD<cr>", opts)
vim.keymap.set("n", "<leader>gs", ":Telescope git_status<cr>", opts)
vim.keymap.set("n", "<leader>gc", ":Telescope git_commits<cr>", opts)
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<cr>", opts)

-- LSP
vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
vim.keymap.set("n", "<leader>cw", "<cmd>Telescope diagnostics<cr>", opts)
vim.keymap.set("n", "<leader>cd", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)
vim.keymap.set("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", opts)
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
vim.keymap.set("n", "<leader>cl", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
vim.keymap.set("n", "<leader>cj", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", opts)
vim.keymap.set("n", "<leader>ck", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", opts)
vim.keymap.set("n", "<leader>cq", "<cmd>lua vim.lsp.diagnostic.setloclist()<cr>", opts)
vim.keymap.set("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
vim.keymap.set("n", "<leader>cs", "<cmd>Telescope lsp_document_symbols<cr>", opts)
vim.keymap.set("n", "<leader>cS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts)

-- rust-tools
vim.keymap.set("n", "<leader>rr", "<cmd>RustRunnables<Cr>", opts)
vim.keymap.set("n", "<leader>re", "<cmd>RustExpandMacro<Cr>", opts)
vim.keymap.set("n", "<leader>ro", "<cmd>RustOpenExternalDocs<Cr>", opts)
vim.keymap.set("n", "<leader>rw",
  "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
  opts)
vim.keymap.set("n", "<leader>rd", "<cmd>RustDebuggables<Cr>", opts)
vim.keymap.set("n", "<leader>rp", "<cmd>RustParentModule<Cr>", opts)
vim.keymap.set("n", "<leader>rc", "<cmd>RustOpenCargo<Cr>", opts)
vim.keymap.set("n", "<leader>rv", "<cmd>RustViewCrateGraph<Cr>", opts)
--            t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
