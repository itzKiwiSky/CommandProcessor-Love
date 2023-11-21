debugstate = {}

function debugstate:enter()
    chocoterm = require 'src.Components.Terminal'
    love.graphics.setBackgroundColor(0.3, 0.3, 0.3)
    term = chocoterm.new(love.graphics.getWidth(), love.graphics.getHeight(), "resources/fonts/vcr.ttf")
end

function debugstate:draw()
    term:draw()
end

function debugstate:update(elapsed)
    term:update(elapsed)
end

function debugstate:keypressed(k)
    if k == "f12" then
        termi:print(string.format("%d\n", math.random(1, 100)))
    end
end

return debugstate