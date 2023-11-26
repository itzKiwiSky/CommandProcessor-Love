local interpreter = require 'src.Archive.Interpreter'

return {
    name = "goto",
    run = function(_line)
        if _line == nil then
            terminalapi.print("[ERROR] : Line parameter needs a value")
            return
        end
        interpreter.line = _line
    end
}