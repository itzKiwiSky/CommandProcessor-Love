local interpreter = require 'src.Components.Lang.Interpreter'

return {
    name = "aoilang",
    description = "Aoilang compiler",
    usage = "aoilang <input-file> <output-file>",
    callback = function(_inputFile, _outputFile)
        if _inputFile ~= nil then
            if _outputFile ~= nil then
                local file = love.filesystem.read(table.concat(ram.buffer[1], "/") .. "/" .. _inputFile)
                for line in file:gmatch("[^\r\n]+") do
                    table.insert(ram.buffer[2], line)
                end
                local outputfile = love.filesystem.newFile(table.concat(ram.buffer[1], "/") .. "/" .. _outputFile, "w")
                outputfile:write(love.data.compress("string", "zlib", json.encode(ram.buffer[2])))
                outputfile:close()
                terminalapi.print("sucessfully compiled")
            else
                terminalapi.print("invalid path\n")
            end
        else
            terminalapi.print("invalid path\n")
        end
    end
}