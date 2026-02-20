-- Load custom icons
local icons = require("core.icons")

local set_keybindings = function()
	-- vim.keymap.set("n", "<leader>F", function() vim.lsp.buf.format { async = true } end, {desc = "Format"})
	vim.keymap.set({ "v", "n" }, "<leader>ca", function()
		vim.lsp.buf.code_action({ apply = true })
	end, { desc = "Code action" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
	vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover over element" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename variable" })
	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic message in float window" })
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.jump({ count = -1, float = true })
	end, { desc = "Previous diagnostic message" })
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.jump({ count = 1, float = true })
	end, { desc = "Next diagnostic message" })
end

return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		name = "mason",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			ensure_installed = { "lua_ls" },
            automatic_enable = true,
		},
		dependencies = { "mason", "lsp" },
		name = "mason-lspconfig",
	},
	{
		"neovim/nvim-lspconfig",
		name = "lsp",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"mason",
		},
		config = function()
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
            vim.lsp.config("asy_lsp", {
                cmd = {'asy', '-lsp'},
                filetypes = {'asy'},
                single_file_support = true,
                settings = {},
            })
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(_)
                    set_keybindings()
                end
            })
			-- vim.fn.sign_define(
			-- 	"DiagnosticSignError",
			-- 	{ texthl = "DiagnosticSignError", text = icons["Error"], numhl = "" }
			-- )
			-- vim.fn.sign_define(
			-- 	"DiagnosticSignWarn",
			-- 	{ texthl = "DiagnosticSignWarn", text = icons["Warn"], numhl = "" }
			-- )
			-- vim.fn.sign_define(
			-- 	"DiagnosticSignHint",
			-- 	{ texthl = "DiagnosticSignHint", text = icons["Hint"], numhl = "" }
			-- )
			-- vim.fn.sign_define(
			-- 	"DiagnosticSignInfo",
			-- 	{ texthl = "DiagnosticSignInfo", text = icons["Info"], numhl = "" }
			-- )

			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded" },
				virtual_text = { prefix = icons["Point"] },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons["Error"],
						[vim.diagnostic.severity.WARN] = icons["Warn"],
						[vim.diagnostic.severity.HINT] = icons["Hint"],
						[vim.diagnostic.severity.INFO] = icons["Info"],
					},
				},
			})
			vim.lsp.inlay_hint.enable()

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})
		end,
	},
}
