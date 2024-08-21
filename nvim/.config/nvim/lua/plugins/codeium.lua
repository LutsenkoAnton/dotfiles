return {
	{
		"Exafunction/codeium.vim",
		config = function()
			vim.keymap.set("i", "<C-Tab>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<M-]>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<M-[>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<C-]>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
			vim.g.codeium_enabled = false
		end,
	},
}
