return {
    name = "clear",
    description = "clear the screen",
    usage = "clear",
    callback = function()
        term.cursor_y = 1
        terminalapi.clear(1, 1, term.width, term.height)
    end
}