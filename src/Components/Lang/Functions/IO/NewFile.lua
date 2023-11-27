return function(_varname, _filename, _mode)
    ram.buffer[3][_varname] = love.filesystem.newFile(table.concat(ram.buffer[1], "/") .. "/" .. _filename, _mode)
end