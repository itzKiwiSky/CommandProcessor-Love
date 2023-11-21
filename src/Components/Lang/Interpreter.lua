local interpreter = {}

interpreter.functions = {}

local function _getVarValue()
    return ram.buffer[3].returnStack
end

local function _parse(_code)
    -- do preprocessing stuff --
    if not string.find(_code, "::%s?[^+]+") then
        -- do variable preprocessing --
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

        -- now do the code stuff --

        local Args = {}

        for match in _code:gmatch("%[([^%]]+)%]") do
            for arg in match:gmatch("[^;]+") do
                table.insert(Args, arg)
            end
        end
            
        return {
            name = string.match(_code, "%$([%w_]+)"),
            args = Args
        }
    end
end

local function _run(_event)
    for f = 1, #interpreter.functions, 1 do
        if _event.name == interpreter.functions[f].name then
            local sucess, err = pcall(interpreter.functions[f].run, unpack(_event.args))
        end
    end
end

function interpreter:init()
    self.code = {}
    self.line = 1
    --self.functions = {}
    self.events = {}

    local funcs = love.filesystem.getDirectoryItems("src/Components/Lang/Functions")

    for f = 1, #funcs, 1 do
        table.insert(interpreter.functions, require("src.Components.Lang.Functions." .. funcs[f]:gsub(".lua", "")))
        print("Function loaded : " .. funcs[f])
    end
end

function interpreter:run(_code)

    -- split code in lines --
    for line in _code:gmatch("[^\r\n]+") do
        table.insert(self.code, line)
    end

    -- do parsing stuff --
    for l = 1, #self.code, 1 do
        if self.code[l] ~= "%s" then
            table.insert(self.events, _parse(self.code[l]))
        end
    end

    for e = 1, #self.events, 1 do
        _run(self.events[e])
    end

    self.events = {}
end

return interpreter