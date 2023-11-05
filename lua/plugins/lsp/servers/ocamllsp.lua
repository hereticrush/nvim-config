local status, lsp = pcall(require("lspconfig"))
if not status then
	return
end
return function(on_attach)
	return {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false
		end,
		cmd = { "ocamllsp" },
		filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
		root_dir = lsp.util.root_pattern(
			"*.opam",
			"esy.json",
			"package.json",
			".git",
			"dune-project",
			"dune-workspace"
		),
	}
end
