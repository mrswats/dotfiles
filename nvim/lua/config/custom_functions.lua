local M = {}

M.screen_share = function()
    local Path = require("plenary.path")
    local alacritty_config_path_string = "~/.config/alacritty/alacritty.yml"
    local alacritty_config_path = Path:new(alacritty_config_path_string)
    local alacritty_file_contents = alacritty_config_path:readlines()
    local size_line_index
    for i, line in ipairs(alacritty_file_contents) do
        if string.find(line, "size") then
            size_line_index = i
        end
    end
    local size_config_string = alacritty_file_contents[size_line_index]

    local t = {}
    for str in string.gmatch(size_config_string, "([^" .. " " .. "]+)") do
        table.insert(t, str)
    end

    local current_size = tonumber(t[2])
    local big_size = 20
    local small_size = 15
    if current_size == small_size then
        alacritty_file_contents[size_line_index] = "  size: " .. big_size
        vim.wo.relativenumber = false
    elseif current_size == big_size then
        alacritty_file_contents[size_line_index] = "  size: " .. small_size
        vim.wo.relativenumber = true
    else
        error("Current size is not expected value:", current_size)
    end

    local alacritty_file_string = table.concat(alacritty_file_contents, "\n")
    alacritty_config_path:write(alacritty_file_string, "w")
end

return M
