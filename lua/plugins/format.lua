return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },

	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			mode = { "n", "v" },
			desc = "Format code (Conform)",
		},
	},

	opts = {
		default_format_opts = {
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			python = { "ruff_fix", "ruff_format" },
			bash = { "shfmt" },

			lua = { "stylua" },
			toml = { "taplo" },

			javascript = { "prettierd", "prettier", stop_after_first = true },
			yaml = { "prettierd", "prettier", stop_after_first = true },
			json = { "prettierd", "prettier", stop_after_first = true },

			["_"] = { "trim_whitespace" },
		},
	},
}
