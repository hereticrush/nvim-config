local util = require("lspconfig.util")
return function(on_attach)
  return {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      client.server_capabilities.document_formatting = true
    end,
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    settings = {
      pyright = {
        autoImportCompletion = true,
      },
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
          typeCheckingMode = "off",
        },
      },
    },
  }
end
