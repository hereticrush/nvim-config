local M = {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions
    local completion = null_ls.builtins.completion
    return {
      debug = true,
      sources = {
        formatting.shfmt,
        formatting.prettier.with({
          filetypes = { "html", "json", "yaml", "markdown", "javascript", "typescript" },
        }),
        formatting.clang_format,
        formatting.taplo,
        formatting.black,
        formatting.asmfmt,
        formatting.stylua,
        formatting.ocamlformat,
        diagnostics.trail_space,
        formatting.eslint_d,
        code_actions.gitsigns,
      },
    }
  end,
}

return M
