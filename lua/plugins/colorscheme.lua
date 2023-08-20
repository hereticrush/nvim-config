local M = {
  'AlexvZyl/nordic.nvim',
  --"folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = function()
    local colors = require("utils").git_colors
    return {
      theme = "dark",
      noice = {
        -- Available styles: `classic`, `flat`.
        style = 'flat',
      },
      telescope = {
        -- Available styles: `classic`, `flat`.
        style = 'flat',
      },
      leap = {
        -- Dims the backdrop when using leap.
        dim_backdrop = false,
      },
      ts_context = {
        -- Enables dark background for treesitter-context window
        dark_background = true,
      },
      -- hide_inactive_statusline = true,
      on_highlights = function(hl, c)
        hl.GitSignsAdd = {
          fg = colors.GitAdd,
        }
        hl.GitSignsChange = {
          fg = colors.GitChange,
        }
        hl.GitSignsDelete = {
          fg = colors.GitDelete,
        }
      end,
    }
  end,
  config = function(_, opts)
    --[[local tokyonight = require("tokyonight")
    tokyonight.setup(opts)
    tokyonight.load()
    ]]
    local nordic = require("nordic")
    nordic.setup(opts)
    nordic.load()
  end,
}

return M
