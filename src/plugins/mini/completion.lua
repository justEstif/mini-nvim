local completion = require("mini.completion")
completion.setup({
	lsp_completion = {
		source_func = "omnifunc",
		auto_setup = false,
		process_items = function(items, base)
			-- Don't show 'Text' and 'Snippet' suggestions
			items = vim.tbl_filter(function(x)
				return x.kind ~= 1 and x.kind ~= 15
			end, items)
			return require("mini.completion").default_process_items(items, base)
		end,
	},
})
