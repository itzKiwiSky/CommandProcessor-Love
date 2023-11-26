local interpreter = require 'src.Components.Lang.Interpreter'

return {
    name = "run",
    description = "run the code sotred on memory",
    usage = "run",
    callback = function()
        if #ram.buffer[2] > 0 then
            interpreter.run(table.concat(ram.buffer[2], "\n"))
            ram.buffer[2] = {}
        else
            terminalapi.printf("No code to run")
            terminalapi.print("\n")
        end
    end
}