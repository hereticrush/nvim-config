local M = {
  "mfussenegger/nvim-dap",
  opt = true,
  event = "BufReadPre",
  module = { "dap" },
  dependencies = {
    {
      "nvim-telescope/telescope.nvim",
      'jbyuki/one-small-step-for-vimkind',
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,

      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require('nvim-dap-virtual-text').setup()
        end
      },
    },
  },
}

function M.init()
  vim.keymap.set("n", "<leader>b", function()
    require("dap").toggle_breakpoint()
  end, { desc = "Toggle Breakpoint" })

  vim.keymap.set("n", "<F5>", function()
    require("dap").continue()
  end, { desc = "Continue" })

  vim.keymap.set("n", "<F10>", function()
    require("dap").step_over()
  end, { desc = "Step Over" })

  vim.keymap.set("n", "<F11>", function()
    require("dap").step_into()
  end, { desc = "Step Into" })

  vim.keymap.set("n", "<leader>dw", function()
    require("dap.ui.widgets").hover()
  end, { desc = "Widgets" })

  vim.keymap.set("n", "<leader>dr", function()
    require("dap").repl.open()
  end, { desc = "Repl" })

  vim.keymap.set("n", "<leader>du", function()
    require("dapui").toggle({
      enable_controls = true,
    })
    --require("dapui").toggle({})
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
  --local dap_virtual_text = require('nvim-dap-virtual-text').setup()

  local install_root_dir = vim.fn.stdpath "data" .. "/mason"
  local extension_path = install_root_dir .. "packages/codelldb/extension/"
  -- local cpptools = "/$HOME/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters"
  local codelldb_path = extension_path .. "adapter/codelldb"
  --local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

  dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode-14",
    -- On windows you may have to uncomment this:
    detached = function()
      if has('win32') then
        local value = false
        return value
      end
    end,
    name = "lldb",
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      runInTerminal = true,
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
  dap.configurations.rust = dap.configurations.cpp

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
