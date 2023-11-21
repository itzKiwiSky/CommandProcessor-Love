local interpreter = require 'src.Components.Lang.Interpreter'

return {
    name = "aoilang",
    callback = function(_file)
        interpreter:run(love.filesystem.read(_file))
    end
}