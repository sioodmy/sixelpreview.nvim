local M = {}

---@param str string
local echoraw = function(str)
	vim.fn.chansend(vim.v.stderr, str)
end

---@param path string
---@param lnum number
---@param cnum number
local send_sequence = function(path, lnum, cnum)
	-- https://zenn.dev/vim_jp/articles/358848a5144b63#%E7%94%BB%E5%83%8F%E8%A1%A8%E7%A4%BA%E9%96%A2%E6%95%B0%E3%81%AE%E4%BE%8B
	-- save cursor pos
	echoraw("\27[s")
	-- move cursor pos
	echoraw(string.format("\27[%d;%dH", lnum, cnum))
	-- display sixels
	echoraw(vim.fn.system(string.format("img2sixel -w 400 %s", path)))
	-- restore cursor pos
	echoraw("\27[u")
end

---@param img_path string
M.display_sixel = function(img_path)
	local win_position = vim.api.nvim_win_get_position(0)
	local y = win_position[1]
	local x = win_position[2]
	send_sequence(img_path, y, x + 1)
end

M.current_line = function()
	local current_line = vim.api.nvim_get_current_line()

	local image_pattern = "!%[.*%]%(([^)]+)%)"
	local _, _, image_path = string.find(current_line, image_pattern)

	if image_path then
		M.display_sixel(image_path)
	end
end

return M
