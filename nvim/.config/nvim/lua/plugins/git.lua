return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		keymaps = {
			{ "]h", nil },
			{ "[h", nil },
			{ "gs", nil, mode = { "n", "v" } },
			{ "gr", nil, mode = { "n", "n" } },
			{ "gS", nil },
			{ "gR", nil },
			{ "gu", nil },
			{ "gp", nil },
			{ "gb", nil },
			{ "gd", nil },
			{ "gD", nil },
			{ "tb", nil },
			{ "td", nil },
			{ "il", nil, mode = { "o", "x" } },
		},
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

				local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(function()
					if vim.wo.diff then
						return "]h"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, function()
					if vim.wo.diff then
						return "[h"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end)

				-- Navigation
				vim.keymap.set("n", "]h", next_hunk_repeat, { buffer = bufnr, expr = true, desc = "Next hunk" })
				vim.keymap.set("n", "[h", prev_hunk_repeat, { buffer = bufnr, expr = true, desc = "Previous hunk" })

				-- Actions
				vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
				vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
				vim.keymap.set("n", "<leader>gS", gs.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
				vim.keymap.set("n", "<leader>gR", gs.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })
				vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
				vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
				vim.keymap.set("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end, { buffer = bufnr, desc = "Blame line" })
				vim.keymap.set("n", "<leader>gd", gs.diffthis, { buffer = bufnr, desc = "Git diff against index" })
				vim.keymap.set("n", "<leader>gD", function()
					gs.diffthis("~")
				end, { buffer = bufnr, desc = "Git diff against last commit" })
				vim.keymap.set("v", "<leader>gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { buffer = bufnr, desc = "Stage selected hunk" })
				vim.keymap.set("v", "<leader>gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { buffer = bufnr, desc = "Reset selected hunk" })

				vim.keymap.set(
					"n",
					"<leader>tb",
					gs.toggle_current_line_blame,
					{ buffer = bufnr, desc = "Toggle line blame" }
				)
				vim.keymap.set(
					"n",
					"<leader>td",
					gs.toggle_deleted,
					{ buffer = bufnr, desc = "Toggle view of deleted lines" }
				)

				-- Text object
				vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr })
			end,
		},
	},
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gc", ":Git commit<CR>", desc = "Git commit" },
		},
		cmd = "Git",
	},
}
