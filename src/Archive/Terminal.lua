local chocoterm = {}
chocoterm.__index = chocoterm

local function _updateChar(_x, _y, _char)
    
end

function chocoterm.new(_w, _h, _font, _customCharWidth, _customCharHeight)
    local t = setmetatable({}, chocoterm)

    print("build shit")

    t.colors = {
        ["black"] = {0,0,0,255},
        ["bred"] = {255,0,0,255},
        ["bblue"] = {0,255,0,255},
        ["bgreen"] = {0,0,255,255},
        ["byellow"] = {255,255,0,255},
        ["bmagenta"] = {255,0,255,255},
        ["bcyan"] = {0,255,255,255},
        ["bwhite"] = {255,255,255,255},
        -- less dark --
        ["dred"] = {128,0,0,255},
        ["dgreen"] = {0,128,0,255},
        ["dblue"] = {0,0,128,255},
        ["dyellow"] = {128,128,0,255},
        ["dmagenta"] = {128,0,128,255},
        ["dcyan"] = {0,128,128,255},
        ["dwhite"] = {128,128,128,255},
    }

    if (type(_font) == "string") then
        t.font = love.graphics.newFont(_font, 20)
    else
        t.font = _font
    end

    t.charW = _customCharWidth or t.font:getWidth('█')
    t.charH = _customCharHeight or t.font:getHeight()
    local numColumns = math.floor(_w / t.charW)
    local numRows = math.floor(_h / t.charH)

    t.buffer = {}
    t.stateBuffer = {}
    t.cursorVisible = true
    t.isDirty = false
    t.cursorX = 1
    t.cursorY = 1
    t.canvas = love.graphics.newCanvas(_w, _h)

    --% initialization stuff %--
    for _y = 1, numRows, 1 do
        local row = {}
        local stateRow = {}
        for _x = 1, numColumns, 1 do
            row[_x] = "."
            stateRow[_x] = {
                fgcolor = t.colors["bwhite"],
                bgcolor = t.colors["black"],
                isDirty = true
            }
        end
        t.buffer[_y] = row
        t.stateBuffer[_y] = stateRow
    end

    love.graphics.setCanvas(t.canvas)
    love.graphics.clear(t.colors["black"][1] / 255, t.colors["black"][2] / 255, t.colors["black"][3] / 255)
    love.graphics.setCanvas()

    return t
end

function chocoterm:print(_text, _x, _y)
    
end

function chocoterm:draw()
    local cw, ch = self.charW, self.charH
    local fh = self.font:getHeight()
    local lastCanvas = love.graphics.getCanvas()
    love.graphics.setFont(self.font)
    if self.isDirty then
        love.graphics.setCanvas(self.canvas)
        for _y, row in ipairs(self.buffer) do
            for _x, char in ipairs(row) do
                local curState = self.stateBuffer[_y][_x]
                local left, top = (_x - 1) * cw, (_y - 1) * ch
                if curState.isDirty then
                    love.graphics.setColor(curState.bgcolor)
                    love.graphics.rectangle("fill", left, top + (fh - ch), self.charW, self.charH)
                    love.graphics.setColor(1, 1, 1, 1)
    
                    love.graphics.setColor(curState.fgcolor)
                    love.graphics.print(char, left, top)
                    curState.isDirty = sssfalse
                end
            end
        end
        love.graphics.setCanvas(lastCanvas)
    end
    self.isDirty = false
    love.graphics.draw(self.canvas, 0, 0)
    love.graphics.print(love.timer.getFPS())
end

function chocoterm:update(elapsed)
    self.isDirty = true
end

return chocoterm