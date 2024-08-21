return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Keymaps (which-key)",
		},
	},
	opts = {
		spec = {
			{ "<leader>f", group = "Find" },
			{ "<leader>g", group = "Git actions", mode = { "n", "v" } },
			{ "<leader>t", group = "Toggle" },
			{ "<leader>d", group = "Dap" },
			{ "<leader>b", group = "Buffer" },
			{ "<leader>bc", group = "Buffer Close" },
		},
		-- layout = {
		--     height = { min = 4, max = 25 },                                         -- min and max height of the columns
		--     width = { min = 20, max = 50 },                                         -- min and max width of the columns
		--     spacing = 3,                                                            -- spacing between columns
		--     align = "left",                                                         -- align columns left, center or right
		-- },
		show_help = true, -- show a help message in the command line for using WhichKey
		show_keys = true, -- show the currently pressed key and its label as a message in the command line
		triggers = {
			{ "<auto>", mode = "nxsot" },
		},
	},
}
