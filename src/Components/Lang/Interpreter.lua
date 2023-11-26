local serializator = require 'src.Components.Lang.Serialization'
local interpreter = {}
interpreter.code = {}
interpreter.bytecodes = {}
interpreter.functions = {}
interpreter.line = 1

local function _runByteCode(_event)
    for f = 1, #interpreter.functions, 1 do
        if _event.name == interpreter.functions[f].name then
            local sucess, err = pcall(interpreter.functions[f].run, unpack(_event.args))
            print(sucess, err)
            if not sucess then
                error(err)
            end
        end
    end
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
    local tree = {}
    for _, file in ipairs(love.filesystem.getDirectoryItems(_path)) do
        local filename = _path .. "/" .. file
        if love.filesystem.getInfo(filename).type == "directory" then
            tree = _loadFunctions(filename)
        elseif file:match(".lua") == ".lua" then
            table.insert(tree, require(filename:gsub(".lua", "")))
            print("loaded : " .. file)
        end
    end
    return tree
end

function interpreter.initialize()
    --table.insert(interpreter.functions, require("src/Components/Lang/Functions/" .. path[p]:gsub(".lua", "")))
    interpreter.functions = _loadFunctions("src/Components/Lang/Functions")
end

function interpreter.jit(_code)
    --print(colors.yellow .. debug.formattable(_parse(_code)) .. colors.reset)
    --print(debug.formattable(_parse(_code)))
    --print(colors.yellow .. _prinextractedFunction(_parse(_code)) .. colors.reset)
    _runByteCode(_parse(_code))
end

return interpreter