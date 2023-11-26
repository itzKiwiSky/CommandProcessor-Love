return {
    name = "mdir",
    description = "create a directory",
    usage = "mdir <name>",
    callback = function(_path)
        local sucess = love.filesystem.createDirectory(table.concat(ram.buffer[1], "/") .. "/" .. _path)
        if not sucess then
            terminalapi.print("Invalid path\n")
        end
    end
}