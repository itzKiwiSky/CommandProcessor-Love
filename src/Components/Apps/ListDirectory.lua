return {
    name = "ls",
    callback = function()
        local items = love.filesystem.getDirectoryItems(table.concat(ram.buffer[1], "/"))
        terminalapi.print("Displaying items from directory " .. table.concat(ram.buffer[1], "/") .. "\n")
        terminalapi.print("------------------------------\n")
        for i = 1, #items, 1 do
            terminalapi.print(items[i] .. "\n")
        end
    end
}