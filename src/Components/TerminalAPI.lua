local terminalapi = {}

function terminalapi.print(_x, _y, ...)
    term:print(_x, _y, ...)
end

function terminalapi.printf(_x, _y, ...)
    if type(_x) == "string" then
        local text = string.tokenize(_x)

        for t = 1, #text, 1 do
            if string.find(text[t], "{([%w]+)}") then
                term:set_cursor_color(terminal.schemes.basic[string.match(text[t], "{([%w]+)}")])
            end
            term:print(text[t]:gsub("({[^>]+})", "") .. " ")
        end
    end 
end

function terminalapi.clear(_x, _y, _w, _h)
    term:clear(_x, _y, _w, _h)
end

function terminalapi.showCursor()
    term:show_cursor()
end

function terminalapi.hideCursor()
    term:hide_cursor()
end

function terminalapi.setCursorPosition(_x, _y)
    term:move_to(_x, _y)
end

function terminalapi.frame(_style, _x, _y, _w, _h)
    term:frame(_style, _x, _y, _w, _h)
end

function terminalapi.setCursorColor(_r, _b, _g, _a)
    term:set_cursor_color(_r, _b, _g, _a)
end

function terminalapi.setCursorBackgroundColor(_r, _b, _g, _a)
    term:set_cursor_backcolor(_r, _b, _g, _a)
end

return terminalapi