local safe_getcharstr = function(msg)
	vim.cmd("echon " .. vim.inspect(msg))
	local ok, res = pcall(vim.fn.getcharstr) -- Allow `<C-c>` to end input
	vim.cmd([[echo '' | redraw]]) -- Clean command line

	-- Treat `<Esc>` or `<CR>` as cancel
	if not ok or (res == "\27" or res == "\r") then
		return nil
	end

	return res
end

local make_ignorecase_pattern = function(word)
	local parts = {}
	for i = 1, word:len() do
		local char = word:sub(i, i)

		if char:find("^%a$") then
			-- Convert letter to a match both lower and upper case
			char = "[" .. char:lower() .. char:upper() .. "]"
		else
			char = vim.pesc(char) -- Escape non-letter characters
		end

		table.insert(parts, char)
	end

	return table.concat(parts)
end

local dummy_spotter = function()
	return {}
end

local jump2d = require("mini.jump2d")

jump2d.setup({
	spotter = dummy_spotter,
	allowed_lines = {
		blank = false,
		fold = false,
	},
	hooks = {
		before_start = function()
			local first = safe_getcharstr("(mini.jump2d) Enter first character: ")
			if first == nil then
				jump2d.config.spotter = dummy_spotter
				return
			end

			local second = safe_getcharstr("(mini.jump2d) Enter second character: ")
			if second == nil then
				jump2d.config.spotter = dummy_spotter
				return
			end

			local pattern = make_ignorecase_pattern(first .. second)
			jump2d.config.spotter = jump2d.gen_pattern_spotter(pattern)
		end,
	},
	mappings = {
		start_jumping = " ",
	},
	labels = "etovxqpdygfblzhckisuran",
})
