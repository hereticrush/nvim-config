return {
	{
		"mfussenegger/nvim-dap",
		event = "BufReadPre",
		module = { "dap" },
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"williamboman/mason.nvim",
			"nvim-telescope/telescope.nvim",
			"jbyuki/one-small-step-for-vimkind",
		},
		config = function()
			local dap = require("dap")
			local virtual_text = require("nvim-dap-virtual-text")
			-- setup dapui
			require("dapui").setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
			})

			-- setting up virtual text
			local display_callback = function(variable, buf, stackframe, node, options)
				if options.virt_text_pos == "inline" then
					return " = " .. variable.value
				else
					return variable.name .. " = " .. variable.value
				end
			end

			virtual_text.setup({
				display_callback = display_callback,
			})
			if not dap.adapters["codelldb"] then
				require("dap").adapters["codelldb"] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "codelldb",
						args = {
							"--port",
							"${port}",
						},
					},
				}
			end

			if not dap.adapters["python"] then
				require("dap").adapters["python"] = {
					type = "executable",
					command = os.getenv("HOME") .. "/.virtualenvs/tools/bin/python",
					args = { "-m", "debugpy.adapter" },
				}
			end

			if not dap.adapters["rust"] then
				local rt = require("lua.plugins.rust-tools")
				require("dap").adapters["rust"] = rt.adapter
			end

			-- if rust then delegate to rust-tools
			for _, lang in ipairs({ "c", "cpp" }) do
				dap.configurations[lang] = {
					{
						type = "codelldb",
						request = "launch",
						name = "Launch file",
						program = function()
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						end,
						cwd = "${workspaceFolder}",
					},
					{
						type = "codelldb",
						request = "attach",
						name = "Attach to process",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end

			vim.keymap.set("n", "<leader>b", "<cmd>DapToggleBreakpoint<cr>", { desc = "Toggle Breakpoint" })

			vim.keymap.set("n", "<F5>", "<cmd>DapContinue<cr>", { desc = "Continue" })

			vim.keymap.set("n", "<F10>", "<cmd>DapStepOver<cr>", { desc = "Step Over" })

			vim.keymap.set("n", "<F11>", "<cmd>DapStepInto<cr>", { desc = "Step Into" })

			vim.keymap.set("n", "<F12>", "<cmd>DapStepOut<cr>", { desc = "Step Out" })

			vim.keymap.set("n", "<leader>dw", function()
				require("dap.ui.widgets").hover()
			end, { desc = "Widgets" })

			vim.keymap.set("n", "<leader>dr", "<cmd>DapToggleRepl<cr>", { desc = "Repl" })

			vim.keymap.set("n", "<leader>du", function()
				require("dapui").toggle()
			end, { desc = "Dap UI" })

			vim.keymap.set("n", "<leader>ds", function()
				require("osv").launch({ port = 8086 })
			end, { desc = "Launch Lua Debugger Server" })

			vim.keymap.set("n", "<leader>dd", function()
				require("osv").run_this()
			end, { desc = "Launch Lua Debugger" })

			dap.listeners.after.event_initialized["dapui_config"] = function()
				require("dapui").open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				require("dapui").close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				require("dapui").close()
			end
		end,
	},
}
