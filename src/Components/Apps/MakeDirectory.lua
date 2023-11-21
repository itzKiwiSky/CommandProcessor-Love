return {
    name = "mkdir",
    callback = function(_path)
        local sucess = love.filesystem.createDirectory(_path)
        if not sucess then
            terminalapi.print("Invalid path\n")
        end
    end
}