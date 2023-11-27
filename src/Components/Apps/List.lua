return {
    name = "list",
    description = "list the content of code stored in memory",
    usage = "list",
    callback = function(_path)
        if #ram.buffer[2] > 0 then
            for c = 1, #ram.buffer[2], 1 do
                terminalapi.print("* " .. ram.buffer[2][c] .. "\n")
            end
        else
            terminalapi.print("No code to display\n")
        end
    end
}