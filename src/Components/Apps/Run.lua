local interpreter = require 'src.Components.Lang.Interpreter'

return {
    name = "run",
    description = "run the code stored on memory",
    usage = "run",
    callback = function()
        if #ram.buffer[2] > 0 then
            for c = 1, #ram.buffer[2], 1 do
                interpreter.jit(ram.buffer[2][c])
            end
            ram.buffer[2] = {}
        else
            terminalapi.printf("No code to run")
            terminalapi.print("\n")
        end
    end
}