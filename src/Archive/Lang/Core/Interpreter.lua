local interpreter = {}
interpreter.functions = {}
interpreter.line = 1

local function _parse(_code)
    --% do preprocessing stuff %--
    if not string.find(_code, "::%s?[^+]+") then
        --% do variable preprocessing %--
        if string.find(_code, "#%w+") then
            local i = 1
            local variables = {}
            for var in _code:gmatch("#%w+") do
                table.insert(variables, var)
            end
            for v = 1, #variables, 1 do
                variables[v] = string.gsub(variables[v], "#%w+", tostring(ram.buffer[3][string.match(variables[v], "%w+")]))
            end
            for var in _code:gmatch("#%w+") do
                _code = _code:gsub(var, variables[i])
                i = i + 1
            end
        end
    end
end

function interpreter:init()
    self.code = {}
    self.events = {}

    local funcs = love.filesystem.getDirectoryItems("src/Components/Lang/Functions")

    for f = 1, #funcs, 1 do
        table.insert(interpreter.functions, require("src.Components.Lang.Functions." .. funcs[f]:gsub(".lua", "")))
        print("Function loaded : " .. funcs[f])
    end
end

return interpreter