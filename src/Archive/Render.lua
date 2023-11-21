local render = {}

local colors = {
    ["white"] = {1, 1, 1},
    ["black"] = {0, 0, 0},
    ["red"] = {1, 0, 0},
    ["green"] = {0, 1, 0},
    ["blue"] = {0, 0, 1},
    ["magenta"] = {1, 0, 1},
    ["yellow"] = {1, 1, 0},
    ["cyan"] = {0, 1, 1},

    ["dwhite"] = {0.5, 0.5, 0.5},
    ["dred"] = {0.5, 0, 0},
    ["dgreen"] = {0, 0.5, 0},
    ["dblue"] = {0, 0, 0.5},
    ["dmagenta"] = {0.5, 0, 0.5},
    ["dyellow"] = {0.5, 0.5, 0},
    ["dcyan"] = {0, 0.5, 0.5},
}

function render:trace(_text)
    local text = string.tokenize(_text)
    local chars = {}
    for c in _text:gmatch(".") do
        table.insert(chars, c)
    end

    for t = 1, #text, 1 do
        if string.find(text[t], "<([%w]+)>") then
            self.color = colors[string.match(text[t], "<([%w]+)>")]
        end
        table.insert(self.buffer, self.color)
        table.insert(self.buffer, " " .. text[t]:gsub("(<[^>]+>)", ""))
    end
    table.insert(self.buffer, self.color)
    table.insert(self.buffer, "\n")
    self.lines = self.lines + 1
end

function render:init(_initialColor)
    _initialColor = _initialColor or "white"
    self.lines = 1
    self.color = colors[_initialColor]
    self.buffer = {}
    self.font = love.graphics.newFont("resources/fonts/vcr.ttf", 20)
end

function render:draw()
    love.graphics.printf(self.buffer, self.font, 0, 0, love.graphics.getWidth(), "left")
    love.graphics.printf("> " .. command, self.font, 0, love.graphics.getHeight() - self.font:getHeight(), love.graphics.getWidth(), "left")
end

function render:update()
    if self.lines < 37 then
        table.remove(self.buffer, 2)
        table.remove(self.buffer, 1)
    end
end

return render