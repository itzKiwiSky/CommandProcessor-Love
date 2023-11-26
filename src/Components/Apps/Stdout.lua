return {
    name = "stdout",
    description = "display messages",
    usage = "stdout <text>",
    callback = function(...)
        terminalapi.print(table.concat({...}, " ") .. "\n")
    end
}