return {
    name = "defvar",
    run = function(_name, _value)
        if _name == nil then
            terminalapi.printf("[ERROR] : Name parameter is required")
            terminalapi.print("\n")
            return
        end
        if _value == nil then
            terminalapi.printf("[ERROR] : Value parameter is required")
            terminalapi.print("\n")
            return
        end
        ram.buffer[3][_name] = _value
    end
}