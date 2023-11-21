local availableColors = {
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    -- less dark --
    "8",
    "9",
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
}

local colorName = {
    "black",
    "blue",
    "green",
    "cyan",
    "red",
    "magenta",
    "yellow",
    "white",
    "gray",
    "bright blue",
    "bright green",
    "bright cyan",
    "bright red",
    "bright magenta",
    "bright yellow",
    "bright white"
}

return {
    name = "color",
    description = "change text and background color",
    callback = function(_color)
        if _color == "help" then
            local lastBgColor = term.cursor_backcolor
            terminalapi.print("Usage: color <colorfg> <colorbg>\n")
            terminalapi.print("\n")
            terminalapi.print("Available colors\n")
            for c = 1, #availableColors, 1 do
                terminalapi.print("[" .. availableColors[c] .. "]   " .. colorName[c] .. "  ")
                terminalapi.setCursorBackgroundColor(terminal.schemes.basic[availableColors[c]])
                terminalapi.print("  \n")
                terminalapi.setCursorBackgroundColor(lastBgColor)
            end
        else
            local color = string.tokenizeWithPattern(_color, ".")
            print(debug.formattable(color))
            local colorfg, colorbg = terminal.schemes.basic[color[1]], terminal.schemes.basic[color[2]]
            print(debug.formattable(colorfg))
            print(debug.formattable(colorbg))
            if colorfg ~= nil then
                if colorbg ~= nil then
                    if color[1] ~= color[2] or color[2] ~= color[1] then
                        for _y = 1, term.height, 1 do
                            for _x = 1, term.width, 1 do
                                term.state_buffer[_y][_x].color = terminal.schemes.basic[color[1]]
                                term.state_buffer[_y][_x].backcolor = terminal.schemes.basic[color[2]]
                                term.state_buffer[_y][_x].dirty = true
                            end
                        end
                        term:set_cursor_backcolor(terminal.schemes.basic[color[2]])
                        term:set_cursor_color(terminal.schemes.basic[color[1]])
                    end
                end
            end
        end
    end
}