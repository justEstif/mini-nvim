local function open_in_split(files)
	local function open_file_in_split(close, vertical)
		return function()
			local is_file = files.get_fs_entry().fs_type == "file"
			if is_file then
				vim.api.nvim_win_call(files.get_target_window(), function()
					vim.cmd.split({
						mods = {
							split = "belowright",
							vertical = vertical,
						},
					})
					files.set_target_window(vim.api.nvim_get_current_win())
				end)
			end

			files.go_in()
			if close and is_file then
				files.close()
			end
		end
	end

	vim.api.nvim_create_autocmd("User", {
		pattern = "MiniFilesBufferCreate",
		callback = function(args)
			local buf_id = args.data.buf_id

			vim.api.nvim_buf_set_keymap(buf_id, "n", "<C-s>", "", {
				callback = open_file_in_split(true, true),
				desc = "Open file in vertical split and close file browser",
			})

			vim.api.nvim_buf_set_keymap(buf_id, "n", "<C-w>s", "", {
				callback = open_file_in_split(false),
				desc = "Open file in horizontal split",
			})

			vim.api.nvim_buf_set_keymap(buf_id, "n", "<C-w>v", "", {
				callback = open_file_in_split(false, true),
				desc = "Open file in vertical split",
			})

			vim.api.nvim_buf_set_keymap(buf_id, "n", "<C-x>", "", {
				callback = open_file_in_split(true),
				desc = "Open file in horizontal split and close file browser",
			})
		end,
	})
end

local function set_cwd(files)
	local files_set_cwd = function()
		-- Works only if cursor is on the valid file system entry
		local cur_entry_path = files.get_fs_entry().path
		local cur_directory = vim.fs.dirname(cur_entry_path)
		vim.fn.chdir(cur_directory)
	end

	vim.api.nvim_create_autocmd("User", {
		pattern = "MiniFilesBufferCreate",
		callback = function(args)
			vim.keymap.set("n", "g~", files_set_cwd, {
				buffer = args.data.buf_id,
				desc = "Set current working directory",
			})
		end,
	})
end

local function toggle_hidden(files)
	local show_hidden = true

	local filter_show = function()
		return true
	end

	local filter_hide = function(fs_entry)
		return not (vim.startswith(fs_entry.name, ".") or (fs_entry.name == "node_modules"))
	end

	local hidden_toggler = function()
		show_hidden = not show_hidden
		local new_filter = show_hidden and filter_show or filter_hide
		files.refresh({
			content = {
				filter = new_filter,
			},
		})
	end

	vim.api.nvim_create_autocmd("User", {
		pattern = "MiniFilesBufferCreate",
		callback = function(args)
			local buf_id = args.data.buf_id
			vim.keymap.set("n", "g.", hidden_toggler, {
				buffer = buf_id,
				desc = "Toggle hidden files",
			})
		end,
	})
end

local files = require("mini.files")
files.setup({
	mappings = {
		go_in = "L",
		go_in_plus = "l",
		go_out = "H",
		go_out_plus = "h",
	},
})
toggle_hidden(files)
set_cwd(files)
open_in_split(files)
