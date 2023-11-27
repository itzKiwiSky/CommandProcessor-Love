return function(_path, _data, _size)
    _size = _size or nil
    ram.buffer[5] = love.filesystem.write(table.concat(ram.buffer[1], "/") .. "/" .. _path, _data, _size)
end