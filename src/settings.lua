vim.g.mapleader = ","

local g = vim.g -- global variables
local opt = vim.opt -- set options (global/buffer/windows-scoped)

-- general
opt.swapfile = false -- don't modify file open in another nvim processs
opt.iskeyword:append("-") -- treat dash separated words as a word text object
opt.clipboard = "unnamedplus"

-- completion
opt.completeopt = "menuone,noinsert,noselect" -- customize completions
opt.switchbuf = "usetab"

-- case-insenstive, unless it has uppercase
opt.ignorecase = true
opt.infercase = true
opt.smartcase = true

-- pop-up menu ui
opt.pumheight = 10 -- pop up menu height
opt.pumblend = 10 -- slight transparent

-- ui
opt.cursorline = true -- show cursorline
opt.relativenumber = true -- show relative line number
opt.number = true -- show line number of current
opt.signcolumn = "yes:1" -- sign column default size
opt.conceallevel = 0 -- `` is visible in markdown files
opt.termguicolors = true -- enable gui colors

-- new window direction
opt.splitright = true
opt.splitbelow = true

-- fold
opt.fillchars = { fold = " " }
opt.foldmethod = "indent"
opt.foldenable = false
opt.foldlevel = 99
g.markdown_folding = 1 -- enable markdown folding

-- tabs, indent
opt.expandtab = true -- convert tabs to spaces
opt.tabstop = 2 -- insert 2 spaces for a tab
opt.smarttab = true -- make tabbing smarter (will realize you have 2 vs 4)
opt.shiftwidth = 2 -- use this number of spaces for indentation
opt.smartindent = true -- make indenting smart

-- memory, cpu
opt.hidden = true -- enable background buffers
opt.history = 200 -- remember n lines in history
opt.synmaxcol = 240 -- max column for syntax highlight
opt.updatetime = 300 -- ms to wait for trigger an event
opt.undofile = true -- enable persistent undo
opt.autoread = true -- auto read files changes

-- fix markdown indentation settings
g.markdown_recommended_style = 0

local augroup = vim.api.nvim_create_augroup("CustomSettings", {})
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	callback = function()
		vim.cmd("setlocal formatoptions-=c formatoptions-=o")
	end,
	desc = [[Ensure proper 'formatoptions']],
})
