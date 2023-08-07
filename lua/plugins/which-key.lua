local M = {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require('which-key').setup()
    end,
    register = function()
      require('which-key').register({
        r = {
          ["<leader>"] = {
            name = "Rust",
            r = { "<cmd>RustRunnables<Cr>", "Runnables" },
            t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
            m = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
            c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
            D = { "<cmd>RustOpenExternalDocs<Cr>", "Open Docs" },
            p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
            d = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
            v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
            R = {
              "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
              "Reload Workspace",
            },
            o = { "<cmd>RustOpenExternalDocs<Cr>", "Open External Docs" },
          }
        },
        f = {
          ["<leader>"] = {
            name = "+file",
            f = { "<cmd>Telescope find_files<cr>", "Find File" },                                     -- create a binding with label
            r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap = false, buffer = 123 }, -- additional options for creating the keymap
            n = { "New File" },                                                                       -- just a label. don't create any mapping
            e = "Edit File",                                                                          -- same as above
            ["1"] = "which_key_ignore",                                                               -- special label to hide it in the popup
            b = { function() print("bar") end, "Foobar" }                                             -- you can also pass functions!
          }
        },
        d = {
          ["<leader>"] = {
            name = "Dap",
            R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
            E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
            C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
            U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
            b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
            c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
            d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
            e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
            g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
            h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
            S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
            i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
            o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
            p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
            q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
            r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
            s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
            t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
            x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
            u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
          }
        },
        h = {
          ["<leader>"] = {
            name = "Harpoon",
            a = { "<cmd>lua require('harpoon_mark').add_file()<CR>", "Add File" },
            u = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toggle Menu" },
            n = { "<cmd>lua require('harpoon.ui').nav_next()<CR>", "Nav Next" },
            p = { "<cmd>lua require('harpoon.ui').nav_prev()<CR>", "Nav Prev" },
            f = { "<cmd>lua require('harpoon.ui').nav_file()<CR>", "Nav File" },
          }
        },
        t = {
          ["<leader>"] = {
            name = "Telescope",
            o = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find Files" },
            p = {
              "<cmd>lua require('telescope.builtin').builtin(require('telescope.themes').get_dropdown({}))<cr>",
              "Get Dropdown"
            },
            g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep" },
            f = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Fuzzy Find" },
          }
        },
        g = {
          ["<leader>"] = {
            name = "Git",
            g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
            j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
            k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
            l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
            p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
            r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
            R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
            s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
            u = {
              "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
              "Undo Stage Hunk",
            },
            o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
            b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
            c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
            d = {
              "<cmd>Gitsigns diffthis HEAD<cr>",
              "Diff",
            }
          },
          l = {
            ["<leader>"] = {
              name = "LSP",
              a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
              d = {
                "<cmd>Telescope diagnostics bufnr=0<cr>",
                "Document Diagnostics",
              },
              w = {
                "<cmd>Telescope diagnostics<cr>",
                "Workspace Diagnostics",
              },
              f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
              i = { "<cmd>LspInfo<cr>", "Info" },
              I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
              j = {
                "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
                "Next Diagnostic",
              },
              k = {
                "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
                "Prev Diagnostic",
              },
              l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
              q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
              r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
              s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
              S = {
                "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                "Workspace Symbols",
              },
            }
          },
          n = {
            ["<leader>"] = {
              name = "NvimTree",
              n = { "<cmd>NvimTreeToggle<CR>", "NvimTree Toggle" },    -- open/close
              r = { "<cmd>NvimTreeRefresh<CR>", "NvimTree Refresh" },  -- refresh
              f = { "<cmd>NvimTreeFindFile<CR>", "NvimTree FindFile" } -- search file
            },
          },
        },
      }, { prefix = "<leader>" })
    end
  },
}

return M
