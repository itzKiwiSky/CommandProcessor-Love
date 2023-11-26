return {
    name = "cd",
    description = "change the directory",
    usage = "cd <dirname>",
    callback = function(_path)
        -- do path formatting --
        if _path == ".." then
            table.remove(ram.buffer[1], #ram.buffer[1])
        else
            local path = string.tokenize(_path, "/")
            for i = 1, #path, 1 do
                table.insert(ram.buffer[1], path[i])
            end
        end
    end
}