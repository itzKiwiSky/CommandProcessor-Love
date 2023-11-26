local serializator = require 'src.Components.Lang.Serialization'
local interpreter = {}
interpreter.bytecodes = {}
interpreter.functions = {}

local function _runByteCode(_event)
    pcall(interpreter.functions[_event.name], unpack(_event.args))
end

local function _parse(_code)
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

    local Args = {}

    -- do function preprocessing -- 

    if string.find(_code, "'[^']+'") then
        for func in _code:gmatch("'[^']+'") do
            local lastItemOnReturnStack = ram.buffer[5]
            _runByteCode(_parse(func:gsub("'", "")))
            _code = _code:gsub("'[^']+'", ram.buffer[5])
        end
    end

    -- parse it into bytecode
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

local function _loadFunctions(_path)
    local items = love.filesystem.getDirectoryItems(_path)
    for item = 1, #items, 1 do
        local path = _path .. "/" .. items[item]
        if love.filesystem.getInfo(path).type == "directory" then
            _loadFunctions(path)
        end
        if love.filesystem.getInfo(path).type == "file" then
            interpreter.functions[string.lower(items[item]:gsub(".lua", ""))] = require(path:gsub(".lua", ""))
            print("Loaded : " .. items[item])
        end
    end
end

function interpreter.initialize()
    _loadFunctions("src/Components/Lang/Functions")
end

function interpreter.jit(_code)
    --print(colors.yellow .. debug.formattable(_parse(_code)) .. colors.reset)
    --print(debug.formattable(_parse(_code)))
    --print(colors.yellow .. _prinextractedFunction(_parse(_code)) .. colors.reset)
    _runByteCode(_parse(_code))
end

return interpreter