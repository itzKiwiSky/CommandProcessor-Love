local cmdparser = {}

local interpreter = require 'src.Components.Lang.Interpreter'

cmdparser.apps = {}

function cmdparser.init()
    local appsfile = love.filesystem.getDirectoryItems("src/Components/Apps")
    for a = 1, #appsfile, 1 do
        table.insert(cmdparser.apps, require("src.Components.Apps." .. appsfile[a]:gsub(".lua", "")))
        print("loaded : " .. appsfile[a])
    end
end

function cmdparser.parse(_text)
    if _text == "" then
        return
    elseif string.startswith(_text, "$") then
        interpreter.jit(_text)
    elseif string.startswith(_text, "*") then
        table.insert(ram.buffer[2], _text:sub(2))
    else
        local tokens = string.tokenize(_text)
        local appname = tokens[1]
        table.remove(tokens, 1)
        for e = 1, #cmdparser.apps, 1 do
            if cmdparser.apps[e].name == appname then
                local sucess, err = pcall(cmdparser.apps[e].callback, unpack(tokens))
                if err ~= nil then
                    error(err)
                end
                return
            end
        end
        terminalapi.print("Invalid command, please type a valid command")
        terminalapi.print("\n")
    end
end

return cmdparser