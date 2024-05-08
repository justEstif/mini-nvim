local catppuccin = require("catppuccin")

catppuccin.setup({
	integrations = {
		markdown = true,
		mason = true,
		treesitter = true,
		mini = { enabled = true },
		native_lsp = {
			enabled = true,
			underlines = {
				errors = { "undercurl" },
				hints = { "undercurl" },
				warnings = { "undercurl" },
				information = { "undercurl" },
			},
		},
	},
})

vim.cmd.colorscheme("catppuccin")
