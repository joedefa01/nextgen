return {
	"stevearc/conform.nvim",
	dependencies = {
		"mason.nvim",
	},
	opts = {
		format_on_save = {
			timeout_ms = 3000,
			lsp_fallback = true,
		},
		format = {
			timeout_ms = 3000,
			async = false, -- not recommended to change
			quiet = false, -- not recommended to change
		},
		formatters_by_ft = {
			lua = { "stylua" },
			fish = { "fish_indent" },
			sh = { "shfmt" },
			python = { "isort", "black" },
			javascript = { "prettierd", "prettier" },
			javascriptreact = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier" },
			typescriptreact = { "prettierd", "prettier" },
			["_"] = { "trim_whitespace" },
		},
		-- The options you set here will be merged with the builtin formatters.
		-- You can also define any custom formatters here.
		formatters = {
			injected = { options = { ignore_errors = true } },
		},
	},
}
