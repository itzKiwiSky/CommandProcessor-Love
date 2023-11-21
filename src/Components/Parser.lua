local cmdparser = {}

local interpreter = require 'src.Components.Lang.Interpreter'

local apps = {}

function cmdparser.init()
    local appsfile = love.filesystem.getDirectoryItems("src/Components/Apps")
    for a = 1, #appsfile, 1 do
        table.insert(apps, require("src.Components.Apps." .. appsfile[a]:gsub(".lua", "")))
        print("loaded : " .. appsfile[a])
    end
end

function cmdparser.parse(_text)
    if _text == "" then
        return
    elseif string.startswith(_text, "$") then
        interpreter:run(_text)
    elseif string.startswith(_text, "*") then
        table.insert(ram.buffer[2], _text:sub(2))
    else
        local tokens = string.tokenize(_text)
        local appname = tokens[1]
        table.remove(tokens, 1)
        for e = 1, #apps, 1 do
            if apps[e].name == appname then
                pcall(apps[e].callback, unpack(tokens))
                return
            end
        end
        terminalapi.print("Invalid command, please type a valid command")
        terminalapi.print("\n")
    end
end

return cmdparser