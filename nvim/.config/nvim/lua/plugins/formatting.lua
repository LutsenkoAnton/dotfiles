return {
	{
		"stevearc/conform.nvim",
		name = "conform",
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>F",
				function()
					require("conform").format({ async = true })
				end,
				desc = "Format",
				mode = { "n", "v" },
			},
			{
				"<leader>Fi",
				function()
					require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
				end,
				desc = "Format Injected",
				mode = { "n", "v" },
			},
		},
		opts = {
			formatters_by_ft = {
				asm = { "asmfmt" },
				bash = { "shfmt" },
				c = { "clang-format" },
				cpp = { "clang-format" },
                go = { "gofmt" },
                haskell = { "ormolu" },
				json = { "jq" },
				lua = { "stylua" },
				markdown = { "prettier" },
                -- proto = { "buf" },
				python = { "isort", "black" },
                rust = { "rustfmt" },
				sql = { "sqlfmt" },
				zsh = { "shfmt" },
			},
			defautlt_format_opts = {
				async = true,
				lsp_format = "fallback",
			},
			notify_on_error = true,
			notify_no_formatters = true,
		},
	},
}
