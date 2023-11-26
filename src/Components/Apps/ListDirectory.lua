return {
    name = "ls",
    description = "list a directory content",
    usage = "ls",
    callback = function()
        local items = love.filesystem.getDirectoryItems(table.concat(ram.buffer[1], "/"))
        terminalapi.print("Displaying items from directory " .. table.concat(ram.buffer[1], "/") .. "\n")
        terminalapi.print("------------------------------\n")
        for i = 1, #items, 1 do
            local data = love.filesystem.getInfo(table.concat(ram.buffer[1], "/") .. "/" .. items[i])
            if data.type == "directory" then
                terminalapi.print("<DIR> ")
            else
                terminalapi.print("<FILE> ")
            end
            terminalapi.print(items[i] .. "\n")
        end
    end
}