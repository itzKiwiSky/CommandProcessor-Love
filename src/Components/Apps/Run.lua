local interpreter = require 'src.Components.Lang.Interpreter'

return {
    name = "run",
    callback = function()
        if #ram.buffer[2] > 0 then
            interpreter:run(table.concat(ram.buffer[2], "\n"))
            ram.buffer[2] = {}
        else
            terminalapi.printf("{c} No code to run {7}")
            terminalapi.print("\n")
        end
    end
}