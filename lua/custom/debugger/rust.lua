local dap = require("dap")

dap.adapters.lldb = {
	type = "executable",
	command = "rust-lldb",
	name = "lldb",
}

dap.configurations.rust = {
	{
		name = "Launch Debug",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/" .. "")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = true,
		args = {},
		initCommand = {},
		runInTerminal = false,
	},
}
