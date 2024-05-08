local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		eruby = { "erb_format" },
		javascript = { "prettier" },
		markdown = { "deno_fmt" },
		json = { "prettier" },
		lua = { "stylua" },
		ruby = { "rufo" },
	},
})
