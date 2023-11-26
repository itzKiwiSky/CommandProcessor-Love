return {
    name = "writeln",
    run = function(...)
        terminalapi.print(table.concat({...}, " ") .. "\n")
    end
}