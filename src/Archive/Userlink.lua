return {
    name = "userlink",
    callback = function(...)
        local tokens = {...}
        local userdata = {
            name = "",
            hasPassword = false,
            password = "",
        }
        if #tokens == 0 then
            terminalapi.print("Available commands for 'userlink'\n")
            terminalapi.print("------------------------------\n")
            terminalapi.print("add | Adds a new user to the machine\n")
            terminalapi.print("list | List all users")
            terminalapi.print("rem | removes a user from the machine and all their data\n")
            terminalapi.print("set-default | set the default user\n")
            terminalapi.print("set-password | set a password to a user\n")
            terminalapi.print("change-user | change the user\n")
        end
        if tokens[1] == "add" then
            if tokens[2] == nil then
                terminalapi.print("Usage: userlink add <username>\n")
            else
                local userfolder = love.filesystem.getInfo(tokens[2])
                if userfolder == nil then
                    love.filesystem.createDirectory(tokens[2])
                    userdata.name = tokens[2]
                    local userfile = love.filesystem.newFile(tokens[2] .. "/.user", "w")
                    userfile:write(json.encode(userdata))
                    userfile:close()
                end
            end
        end
    end
}