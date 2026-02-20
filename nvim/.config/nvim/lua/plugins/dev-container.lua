return {
	{
		"https://codeberg.org/esensar/nvim-dev-container",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {},
		cmd = { "DevcontainerStart", "DevcontainerAttach", "DevcontainerExec", "DevcontainerEditNearestConfig" },
		-- "jamestthompson3/nvim-remote-containers",
		-- cmd = { "AttachToContainer" },
	},
}
