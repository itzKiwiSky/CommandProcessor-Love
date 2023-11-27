local interpreter = require 'src.Components.Lang.Interpreter'

return function(_expr)
    interpreter.jit(_expr)
end