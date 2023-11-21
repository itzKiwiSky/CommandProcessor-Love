playstate = {}

function playstate:enter()
    terminalapi = require 'src.Components.TerminalAPI'
    parser = require 'src.Components.Parser'
    ram = require 'src.Components.Virtualization.RAM'
    interpreter = require 'src.Components.Lang.Interpreter'

    ram.buffer.user = "root"
    ram.buffer.state = "static"
    ram.buffer[1] = {ram.buffer.user}      -- path rs
    ram.buffer[2] = {}      -- commands accumulator
    ram.buffer[3] = {}      -- var stack
    ram.buffer[4] = {}      -- function stack
    ram.buffer[5] = nil     -- return stack
    ram.buffer[6] = {
        {
            name = "shaders",
            value = true
        }
    }

    effect = moonshine(moonshine.effects.glow).chain(moonshine.effects.crt).chain(moonshine.effects.scanlines)
    effect.scanlines.opacity = 0.4

    command = ""

    vcr = love.graphics.newFont("resources/fonts/vcr.ttf", 20)
    headupdaisy = love.graphics.newFont("resources/fonts/headupdaisy.ttf", 20)
    phoenixbios = love.graphics.newFont("resources/fonts/phoenixbios.ttf", 20)
    term = terminal(love.graphics.getWidth(), love.graphics.getHeight() - headupdaisy:getHeight(), headupdaisy)

    cover = love.graphics.newImage("resources/images/cover.png")

    term:set_cursor_color(terminal.schemes.basic["7"])
    interpreter:init()
    print("--------------------------")
    parser.init()
    print("/--------------------------\\")
    print("|        CherrySystem      |")
    print("|           v0.0.1         |")
    print("\\--------------------------/")

end

function playstate:draw()
    effect(function()
        term:draw()
        love.graphics.setColor(1, 1, 1, 0.6)
        love.graphics.draw(cover, 0, 0)
        love.graphics.setColor(1, 1, 1, 1)
    end)
    --love.graphics.print(term.cursor_x, 0, 0)
    --love.graphics.print(term.cursor_y, 100, 0)
    --love.graphics.print(debug.formattable(term.buffer), 0, 30)
    --print(term.cursor_x,term.cursor_y)

end

function playstate:update(elapsed)
    term:update(elapsed)
    if term.cursor_x < 1 then
        term.cursor_x = 1
    end
    --if term.cursor_y > 47 then
        --term:doScroll(1)
        --term.cursor_y = 47
    --end
end

function playstate:textinput(t)
    if ram.buffer.state == "static" then
        command = command .. t
        term:print(t)
    end
end

function playstate:keypressed(k)
    if ram.buffer.state == "static" then
        if k == "backspace" then
            local byteoffset = utf8.offset(command, -1)
            if byteoffset then
                command = string.sub(command, 1, byteoffset - 1)
            end
            if term.cursor_x > 1 then
                term.cursor_x = term.cursor_x - 1
                term:clear(term.cursor_x, term.cursor_y, 1, 1)
            end
        end
        if k == "return" then
            term.cursor_x = 1
            term:print("\n")
            parser.parse(string.lower(command))
            command = ""
        end
    elseif ram.buffer.state == "immediate" then

    end
    if k == "f1" then
        print(debug.formattable(ram.buffer[2]))
        print(debug.formattable(ram.buffer[3]))
    end
end

return playstate