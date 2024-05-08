vim.g.mapleader = ","

vim.cmd("filetype plugin indent on") -- Enable all filetype plugins
vim.o.cursorline = true -- Enable highlighting of the current line
vim.o.laststatus = 2 -- Always show statusline
vim.o.clipboard = "unnamedplus" -- Use system clipboard
vim.o.completeopt = "menuone,noinsert,noselect" -- Customize completions

-- Tabs, indent
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.tabstop = 2 -- Insert 2 spaces for a tab
vim.o.smarttab = true -- Make tabbing smarter (will realize you have 2 vs 4)
vim.o.shiftwidth = 2 -- Use this number of spaces for indentation
vim.o.smartindent = true -- Make indenting smart

-- Editing ====================================================================
vim.o.autoindent = true -- Use auto indent
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.formatoptions = "rqnl1j" -- Improve comment editing
vim.o.ignorecase = true -- Ignore case when searching (use `\C` to force not doing that)
vim.o.incsearch = true -- Show search results while typing
vim.o.infercase = true -- Infer letter cases for a richer built-in keyword completion
vim.o.shiftwidth = 2 -- Use this number of spaces for indentation
vim.o.smartcase = true -- Don't ignore case when searching if pattern has upper case
vim.o.smartindent = true -- Make indenting smart
vim.o.tabstop = 2 -- Insert 2 spaces for a tab
vim.o.virtualedit = "block" -- Allow going past the end of line in visual block mode

-- Memory, CPU
vim.opt.hidden = true -- Enable background buffers
vim.opt.history = 200 -- Remember N lines in history
vim.opt.synmaxcol = 240 -- Max column for syntax highlight
vim.opt.updatetime = 300 -- ms to wait for trigger an event
vim.opt.undofile = true -- enable persistent undo
vim.opt.autoread = true -- auto read files changes

vim.opt.iskeyword:append("-") -- Treat dash separated words as a word text object

-- Fold
vim.o.foldmethod = "indent"
vim.o.foldenable = false
vim.o.foldlevel = 99
vim.g.markdown_folding = 1 -- enable markdown folding
-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- new window direction
vim.o.splitright = true
vim.o.splitbelow = true

local augroup = vim.api.nvim_create_augroup("CustomSettings", {})
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	callback = function()
		vim.cmd("setlocal formatoptions-=c formatoptions-=o")
	end,
	desc = [[Ensure proper 'formatoptions']],
})
