return {
    name = "load",
    description = "load the code stored on disk to memory",
    usage = "load <filename>",
    callback = function(_path)
        if love.filesystem.getInfo(table.concat(ram.buffer[1], "/") .. "/" .. _path) ~= nil then
            local file = love.filesystem.read(table.concat(ram.buffer[1], "/") .. "/" .. _path)
            for line in file:gmatch("[^\r\n]+") do
                table.insert(ram.buffer[2], line)
            end
            terminalapi.print("Loaded from disk with sucess\n")
        else
            terminalapi.print("invalid path\n")
        end
    end
}