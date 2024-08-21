return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				event = "VeryLazy",
				config = function()
					local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

					-- vim way: ; goes to the direction you were moving.
					vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
					vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

					vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
					vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
					vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
					vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
					vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
					vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
				end,
			},
		},
		opts = {
			ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "regex", "bash", "markdown", "markdown_inline" },

			auto_install = true,

			ignore_install = {},
			modules = {},

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = { "latex", "tex" },
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["i="] = { query = "@assignment.inner", desc = "inner assignment statement" },
						["l="] = { query = "@assignment.lhs", desc = "Left hand side of assignment statment" },
						["a="] = { query = "@assignment.outer", desc = "an assignment statement" },
						["r="] = { query = "@assignment.rhs", desc = "Right hand side of assignment statement" },
						["ib"] = { query = "@block.inner", desc = "inner block of code" },
						["ab"] = { query = "@block.outer", desc = "a block of code" },
						["ica"] = { query = "@call.inner", desc = "inner call of function" },
						["aca"] = { query = "@call.outer", desc = "a call of function" },
						["icl"] = { query = "@class.inner", desc = "inner class" },
						["acl"] = { query = "@class.outer", desc = "a class" },
						["ico"] = { query = "@comment.inner", desc = "inner comment" },
						["aco"] = { query = "@comment.outer", desc = "a comment" },
						["ii"] = { query = "@conditional.inner", desc = "inner if/else/else if" },
						["ai"] = { query = "@conditional.outer", desc = "an if/else/else if" },
						["if"] = { query = "@function.inner", desc = "inner function" },
						["af"] = { query = "@function.outer", desc = "a function" },
						["il"] = { query = "@loop.inner", desc = "inner loop" },
						["al"] = { query = "@loop.outer", desc = "outer loop" },
						["an"] = { query = "@number.inner", desc = "a number" },
						["ip"] = { query = "@parameter.inner", desc = "inner parameter" },
						["ap"] = { query = "@parameter.outer", desc = "a parameter" },
						["ir"] = { query = "@return.inner", desc = "inner return statement" },
						["ar"] = { query = "@return.outer", desc = "a return statement" },
					},
				},
				swap = {
					enable = "true",
					swap_next = {
						["<leader>p"] = { query = "@parameter.inner", desc = "Swap parameter with next one" },
					},
					swap_previous = {
						["<leader>P"] = { query = "@parameter.inner", desc = "Swap parameter with previous one" },
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]ca"] = { query = "@call.outer", desc = "Next function call start" },
						["]cl"] = { query = "@class.outer", desc = "Next class start" },
						["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
						["]f"] = { query = "@function.outer", desc = "Next method/function def start" },
						["]l"] = { query = "@loop.outer", desc = "Next loop start" },
					},
					goto_next_end = {
						["]CA"] = { query = "@call.outer", desc = "Next function call end" },
						["]CL"] = { query = "@class.outer", desc = "Next class end" },
						["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
						["]F"] = { query = "@function.outer", desc = "Next method/function def end" },
						["]L"] = { query = "@loop.outer", desc = "Next loop end" },
					},
					goto_previous_start = {
						["[ca"] = { query = "@call.outer", desc = "Previous function call start" },
						["[cl"] = { query = "@class.outer", desc = "Previous class start" },
						["[i"] = { query = "@conditional.outer", desc = "Previous conditional start" },
						["[f"] = { query = "@function.outer", desc = "Previous method/function def start" },
						["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
					},
					goto_previous_end = {
						["[CA"] = { query = "@call.outer", desc = "Previous function call end" },
						["[CL"] = { query = "@class.outer", desc = "Previous class end" },
						["[I"] = { query = "@conditional.outer", desc = "Previous conditional end" },
						["[F"] = { query = "@function.outer", desc = "Previous method/function def end" },
						["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		keys = {
			{
				"[co",
				function()
					require("treesitter-context").go_to_context(vim.v.count1)
				end,
				desc = "Jump upwards in context",
				silent = true,
			},
		},
	},
}
