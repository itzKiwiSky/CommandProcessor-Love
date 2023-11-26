return {
    name = "write",
    run = function(...)
        terminalapi.print(table.concat({...}, " "))
    end
}