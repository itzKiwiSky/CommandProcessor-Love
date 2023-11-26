local cmdparser = require 'src.Components.Parser'

return {
    name = "help",
    description = "this is the help message",
    usage = "help <command>",
    callback = function(_command)
        if _command == nil then
            terminalapi.print("Displaying all available commands\n")
            terminalapi.print("---------------------------------\n")
            for a = 1, #cmdparser.apps, 1 do
                terminalapi.print(cmdparser.apps[a].name .. " | " .. cmdparser.apps[a].description .. "\n")
            end
        else
            for a = 1, #cmdparser.apps, 1 do
                if cmdparser.apps[a].name == _command then
                    terminalapi.print(cmdparser.apps[a].usage .. "\n")
                end
            end
        end
    end
}