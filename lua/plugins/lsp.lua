return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp", -- Dla capabilities
		},
		config = function()
			require("mason").setup()

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.general = capabilities.general or {}
			capabilities.general.positionEncodings = { "utf-16" }

			require("mason-lspconfig").setup({
				ensure_installed = { "basedpyright", "ruff", "bashls" },
				handlers = {
					-- Ta funkcja uruchomi się automatycznie dla KAŻDEGO serwera z listy wyżej
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
				},
			})

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				update_in_insert = false,
				float = {
					border = "rounded",
					source = true,
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(event)
					local opts = { buffer = event.buf, silent = true }

					vim.keymap.set(
						"n",
						"K",
						vim.lsp.buf.hover,
						vim.tbl_extend("force", opts, { desc = "LSP: show docs" })
					)
					vim.keymap.set(
						"n",
						"gd",
						vim.lsp.buf.definition,
						vim.tbl_extend("force", opts, { desc = "LSP: go to def" })
					)
					vim.keymap.set(
						"n",
						"<leader>ca",
						vim.lsp.buf.code_action,
						vim.tbl_extend("force", opts, { desc = "LSP: Code Action" })
					)
					vim.keymap.set(
						"n",
						"gl",
						vim.diagnostic.open_float,
						vim.tbl_extend("force", opts, { desc = "LSP: show error" })
					)
				end,
			})
		end,
	},
}
