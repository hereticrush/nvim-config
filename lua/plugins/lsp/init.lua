return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"folke/neoconf.nvim",
			"b0o/schemastore.nvim",
		},
		config = function()
			require("neodev").setup({})
			local lspconfig = require("lspconfig")
			local lsp_defaults = require("lspconfig.util").default_config
			local status_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")

			local capabilities
			if status_ok then
				capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, cmp_lsp.default_capabilities())
			else
				capabilities = vim.lsp.protocol.make_client_capabilities()
			end

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "shadow" })
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "shadow" })

			local function on_attach()
				vim.api.nvim_create_autocmd("LspAttach", {
					callback = function(args)
						local buffer = args.buf
						local client = vim.lsp.get_client_by_id(args.data.client_id)
						--on_attach(client, buffer)
						vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")
						on_attach()
					end,
				})
			end

			local default_lsp_config = {
				on_attach = on_attach,
				capabilities = capabilities,
				flags = {
					debounce_text_changes = 200,
					allow_incremental_sync = true,
				},
			}

			vim.diagnostic.config({
				virtual_text = false,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
				signs = true,
				underline = true,
				update_in_insert = true,
				severity_sort = false,
			})

			---- sign column
			local signs = require("utils").lsp_signs

			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf, noremap = true, silent = true }
					vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<cr>", opts)
					vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>", opts)
					vim.keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<cr>", opts)
					vim.keymap.set("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<cr>", opts)
					vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})

			-- show diagnostics in hover window
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					local opts = {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
						border = "rounded",
						source = "always",
						prefix = " ",
						scope = "cursor",
					}
					vim.diagnostic.open_float(nil, opts)
				end,
			})

			local servers = {
				--codelldb = {},
				clangd = require("plugins.lsp.servers.clangd")(on_attach),
				cmake = {},
				tsserver = require("plugins.lsp.servers.tsserver")(on_attach),
				pyright = require("plugins.lsp.servers.pyright")(on_attach),
				eslint = require("plugins.lsp.servers.eslint")(on_attach),
				bashls = require("plugins.lsp.servers.bashls")(on_attach),
				yamlls = require("plugins.lsp.servers.yamlls")(on_attach),
				jsonls = require("plugins.lsp.servers.jsonls")(on_attach),
				cssls = {},
				taplo = {},
				html = {},
				tailwindcss = {},
				lua_ls = require("plugins.lsp.servers.lua_ls")(on_attach),
				ocamllsp = require("plugins.lsp.servers.ocamllsp")(on_attach),
			}

			local server_names = {}
			for server in pairs(servers) do
				table.insert(server_names, server)
			end

			local present_mason, mason = pcall(require, "mason-lspconfig")
			if present_mason then
				mason.setup({ ensure_installed = server_names })
			end

			for server, config in pairs(servers) do
				local final_config = vim.tbl_deep_extend("force", default_lsp_config, config)
				lspconfig[server].setup(final_config)
				if server == "rust_analyzer" then
					local present_rust_tools, rust_tools = pcall(require, "rust-tools")
					if present_rust_tools then
						rust_tools.setup({ server = final_config })
					end
				end
			end
		end,
	},
}
