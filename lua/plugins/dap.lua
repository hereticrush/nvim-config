local M = {
  "mfussenegger/nvim-dap",
  opt = true,
  event = "BufReadPre",
  module = { "dap" },
  dependencies = {
    {
      'jbyuki/one-small-step-for-vimkind',
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
    },
  },
}

function M.init()
  vim.keymap.set("n", "<leader>db", function()
    require("dap").toggle_breakpoint()
  end, { desc = "Toggle Breakpoint" })

  vim.keymap.set("n", "<leader>dc", function()
    require("dap").continue()
  end, { desc = "Continue" })

  vim.keymap.set("n", "<leader>do", function()
    require("dap").step_over()
  end, { desc = "Step Over" })

  vim.keymap.set("n", "<leader>di", function()
    require("dap").step_into()
  end, { desc = "Step Into" })

  vim.keymap.set("n", "<leader>dw", function()
    require("dap.ui.widgets").hover()
  end, { desc = "Widgets" })

  vim.keymap.set("n", "<leader>dr", function()
    require("dap").repl.open()
  end, { desc = "Repl" })

  vim.keymap.set("n", "<leader>du", function()
    require("dapui").toggle({})
    require("dapui").toggle({})
  end, { desc = "Dap UI" })

  vim.keymap.set("n", "<leader>ds", function()
    require("osv").launch({ port = 8086 })
  end, { desc = "Launch Lua Debugger Server" })

  vim.keymap.set("n", "<leader>dd", function()
    require("osv").run_this()
  end, { desc = "Launch Lua Debugger" })
end

function M.config()
  local dap = require("dap")
  local dapui = require("dapui")

  local install_root_dir = vim.fn.stdpath "data" .. "/mason"
  local extension_path = install_root_dir .. "packages/codelldb/extension/"
  -- local cpptools = "/$HOME/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters"
  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
  dap.adapters.codelldb = {
    type = "server",
    port = "13000",
    executable = {
      -- CHANGE THIS to your path!
      command = codelldb_path,
      args = { "--port", "13000" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      cwd = "${workspaceFolder}",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      stopOnEntry = true,
    },
  }
  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
      host = function()
        local value = vim.fn.input "Host [127.0.0.1]: "
        if value ~= "" then
          return value
        end
        return "127.0.0.1"
      end,
      port = function()
        local val = tonumber(vim.fn.input("Port: ", "54321"))
        assert(val, "Please provide a port number")
        return val
      end,
    },
  }

  dap.configurations.c = dap.configurations.cpp
  local opts = {
    dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
    },
  }

  require('rust-tools').setup { opts }

  dap.adapters.nlua = function(callback, config)
    callback { type = "server", host = config.host, port = config.port }
  end
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

return M
