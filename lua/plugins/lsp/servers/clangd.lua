local clangd_ext_opts = require("clangd_extensions").opts
return function(on_attach)
  return {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    capabilities = {
      offsetEncoding = { "utf-16" },
    },
    keys = { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
    clangd = function(_, opts)
      vim.tbl_deep_extend("force", clangd_ext_opts or {}, opts)
    end,
    root_dir = function(fname)
      return require("lspconfig.util").root_pattern(
        "Makefile",
        "configure.ac",
        "configure.in",
        "config.h.in",
        "meson.build",
        "meson_options.txt",
        "build.ninja"
      )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname) or require(
        "lspconfig.util"
      ).find_git_ancestor(fname)
    end,
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
    single_file_support = true,
  }
end
