return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			style = "night",
			transparent = true,
			terminal_colors = true,
			styles = {
				comments = { italic = false },
				keywords = { italic = false },
				sidebars = "transparent",
				floats = "transparent",
			},
			sidebars = { "qf", "help", "terminal" },
			hide_inactive_statusline = false,
			dim_inactive = false,
		},
	},
}
