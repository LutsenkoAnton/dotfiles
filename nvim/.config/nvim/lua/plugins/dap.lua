return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Continue debugging",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Step over",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step into",
			},
			{
				"<leader>du",
				function()
					require("dap").step_out()
				end,
				desc = "Step out",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint, c - set condition, l - log message",
			},
			{
				"<leader>dbc",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "), nil, nil)
				end,
				desc = "Breakpoint on condition",
			},
			{
				"<leader>dbl",
				function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end,
				desc = "Breakpoint with log message",
			},
			{
				"<leader>dbcl",
				function()
					require("dap").set_breakpoint(
						vim.fn.input("Breakpoint condition: "),
						nil,
						vim.fn.input("Log point message: ")
					)
				end,
				desc = "Breakpoit on condition with log message",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "Open REPl",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Restart debug session",
			},
		},
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
				opts = {},
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {
					enabled = true, -- enable this plugin (the default)
					enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
					highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
					highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
					show_stop_reason = true, -- show stop reason when stopped for exceptions
					commented = false, -- prefix virtual text with comment string
					only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
					all_references = false, -- show virtual text on all all references of the variable (not only definitions)
					clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
					--- A callback that determines how a variable is displayed or whether it should be omitted
					--- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
					--- @param buf number
					--- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
					--- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
					--- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
					--- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
					display_callback = function(variable, _, _, _, options)
						if options.virt_text_pos == "inline" then
							return " = " .. variable.value
						else
							return variable.name .. " = " .. variable.value
						end
					end,
					-- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
					virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

					-- experimental features:
					all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
					virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
					virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
					-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
				},
			},
			{
				"rcarriga/cmp-dap",
				dependencies = { "cmp" },
				config = function()
					require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
						sources = {
							{ name = "dap" },
						},
					})
				end,
			},
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			local icons = require("core.icons")
			vim.fn.sign_define("DapBreakpoint", { text = icons["Point"], texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = icons["BreakpointCondition"], texthl = "", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = icons["LogPoint"], texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = icons["DapStopped"], texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = icons["BreakpointRejected"], texthl = "", linehl = "", numhl = "DiagnosticSignError" }
			)

			-- Configurations here:
			-- GDB
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			}
			dap.configurations.c = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
				{
					name = "Select and attach to process",
					type = "gdb",
					request = "attach",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					pid = function()
						local name = vim.fn.input("Executable name (filter): ")
						return require("dap.utils").pick_process({ filter = name })
					end,
					cwd = "${workspaceFolder}",
				},
				{
					name = "Attach to gdbserver :1234",
					type = "gdb",
					request = "attach",
					target = "localhost:1234",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
			}
			dap.configurations.cpp = dap.configurations.c
			dap.configurations.asm = dap.configurations.c
		end,
	},
}
