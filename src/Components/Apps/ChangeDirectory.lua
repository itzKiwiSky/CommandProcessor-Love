return {
    name = "cd",
    callback = function(_path)
        -- do path formatting --
        local path = string.tokenize(_path, "/")
        for i = 1, #path, 1 do
            table.insert(ram.buffer[1], path[i])
        end
    end
}