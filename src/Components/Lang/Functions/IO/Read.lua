return function(_path)
    ram.buffer[5] = love.filesystem.read(table.concat(ram.buffer[1], "/") .. "/" .. _path)
end