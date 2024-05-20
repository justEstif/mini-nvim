local theme = require("tokyonight")

theme.setup({
	styles = {
		comments = { italic = false },
		keywords = { italic = false },
	},
})

vim.cmd.colorscheme("tokyonight")
