local M = {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
    "nvim-telescope/telescope.nvim",
  },
}

function M.setup()
  local opts = { noremap = true, silent = true }
  local keymap = vim.keymap.set
  require('telescope').load_extension('harpoon')
  keymap("n", "<leader>ha", ":lua require('harpoon_mark').add_file()<CR>", opts)
  keymap("n", "<leader>hu", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
  keymap("n", "<leader>hn", ":lua require('harpoon.ui').nav_next()<CR>", opts)
  keymap("n", "<leader>hp", ":lua require('harpoon.ui').nav_prev()<CR>", opts)
  keymap("n", "<leader>nf", ":lua require('harpoon.ui').nav_file()<CR>", opts)
end

return M
