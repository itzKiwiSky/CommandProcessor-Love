local interpreter = require 'src.Components.Lang.Interpreter'

return {
    name = "eval",
    run = function(_code)
        interpreter:run(_code)
    end
}