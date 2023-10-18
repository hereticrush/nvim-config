return {
	{
		"simrat39/rust-tools.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local lspconfig = require("lspconfig")
			require("rust-tools").setup({
				opts = {
					tools = {
						executor = require("rust-tools.executors").quickfix,
						reload_workspace_from_cargo_toml = true,
						inlay_hints = {
							-- automatically set inlay hints (type hints)
							-- default: true
							auto = true,

							-- Only show inlay hints for the current line
							only_current_line = false,

							-- whether to show parameter hints with the inlay hints or not
							-- default: true
							show_parameter_hints = true,

							-- prefix for parameter hints
							-- default: "<-"
							parameter_hints_prefix = "<- ",

							-- prefix for all the other hints (type, chaining)
							-- default: "=>"
							other_hints_prefix = "=> ",

							-- whether to align to the length of the longest line in the file
							max_len_align = false,

							-- padding from the left if max_len_align is true
							max_len_align_padding = 1,

							-- whether to align to the extreme right or not
							right_align = false,

							-- padding from the right if right_align is true
							right_align_padding = 7,

							-- The color of the hints
							highlight = "Comment",
						},
						-- options same as lsp hover / vim.lsp.util.open_floating_preview()
						hover_actions = {

							-- the border that is used for the hover window
							-- see vim.api.nvim_open_win()
							border = {
								{ "╭", "FloatBorder" },
								{ "─", "FloatBorder" },
								{ "╮", "FloatBorder" },
								{ "│", "FloatBorder" },
								{ "╯", "FloatBorder" },
								{ "─", "FloatBorder" },
								{ "╰", "FloatBorder" },
								{ "│", "FloatBorder" },
							},

							-- Maximal width of the hover window. Nil means no max.
							max_width = nil,

							-- Maximal height of the hover window. Nil means no max.
							max_height = nil,

							-- whether the hover action window gets automatically focused
							-- default: false
							auto_focus = true,
						},
					},
					-- settings for showing the crate graph based on graphviz and the dot
					-- command
					crate_graph = {
						-- Backend used for displaying the graph
						-- see: https://graphviz.org/docs/outputs/
						-- default: x11
						backend = "x11",
						-- where to store the output, nil for no output stored (relative
						-- path from pwd)
						-- default: nil
						output = nil,
						-- true for all crates.io and external crates, false only the local
						-- crates
						-- default: true
						full = true,

						-- List of backends found on: https://graphviz.org/docs/outputs/
						-- Is used for input validation and autocompletion
						-- Last updated: 2021-08-26
						enabled_graphviz_backends = {
							"bmp",
							"cgimage",
							"canon",
							"dot",
							"gv",
							"xdot",
							"xdot1.2",
							"xdot1.4",
							"eps",
							"exr",
							"fig",
							"gd",
							"gd2",
							"gif",
							"gtk",
							"ico",
							"cmap",
							"ismap",
							"imap",
							"cmapx",
							"imap_np",
							"cmapx_np",
							"jpg",
							"jpeg",
							"jpe",
							"jp2",
							"json",
							"json0",
							"dot_json",
							"xdot_json",
							"pdf",
							"pic",
							"pct",
							"pict",
							"plain",
							"plain-ext",
							"png",
							"pov",
							"ps",
							"ps2",
							"psd",
							"sgi",
							"svg",
							"svgz",
							"tga",
							"tiff",
							"tif",
							"tk",
							"vml",
							"vmlz",
							"wbmp",
							"webp",
							"xlib",
							"x11",
						},
					},
				},
				server = {
					-- standalone file support
					-- setting it to false may improve startup time
					standalone = true,
					-- root_dir = require("lspconfig/util").root_pattern("Cargo.toml"),
					settings = {
						["rust_analyzer"] = {
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								runBuildScripts = true,
							},
						},
					},
					checkOnSave = {
						allFeatures = true,
						overrideCommand = {
							"cargo",
							"clippy",
							"--workspace",
							"--message-format=json",
							"--all-targets",
							"--all-features",
						},
					},
					procMacro = {
						enable = true,
						ignored = {
							["async-trait"] = { "async_trait" },
							["napi-derive"] = { "napi" },
							["async-recursion"] = { "async_recursion" },
						},
					},
					-- rust-analyzer options
				},
				adapter = function()
					local ok, mason_registry = pcall(require, "mason-registry")
					local adapter
					if ok then
						-- rust tools configuration for debugging support
						local codelldb = mason_registry.get_package("codelldb")
						local extension_path = codelldb:get_install_path() .. "/extension/"
						local codelldb_path = extension_path .. "adapter/codelldb"
						local liblldb_path = ""
						if vim.loop.os_uname().sysname:find("Windows") then
							liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
						elseif vim.fn.has("mac") == 1 then
							liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
						else
							liblldb_path = extension_path .. "lldb/lib/liblldb.so"
						end
						adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
					end
					return {
						dap = {
							adapter = adapter,
						},
						tools = {
							on_initialized = function()
								vim.cmd([[
                augroup RustLSP
                  autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                  autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                  autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                augroup END
              ]])
							end,
						},
					}
				end,
			})
		end,
	},
}
