return {
	{
		"lervag/vimtex",
		ft = { "tex", "latex" },
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "zathura"
			vim.g.latex_view_general_viewer = "zathura"
			vim.g.vimtex_compiler_progname = "nvr"
			vim.g.vimtex_compiler_engine = "lualatex"
		end,
	},
}
