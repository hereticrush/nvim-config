local M = {
  'rcarriga/nvim-notify',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons"
  },
  event = "VeryLazy",
  render = function(bufnr, notif, highlights)

  end,
  init = function()
    local plugin = "Yo!"
    local async = require("plenary.async")
    vim.notify("Experimental", nil, {title = plugin })
  end
}


return M
