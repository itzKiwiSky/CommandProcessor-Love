function love.load()
    utf8 = require 'utf8'
    moonshine = require 'libraries.post-processing.moonshine'
    gamestate = require 'libraries.control.gamestate'
    lume = require 'libraries.control.lume'
    timer = require 'libraries.control.timer'
    nativefs = require 'libraries.filesystem.nativefs'
    json = require 'libraries.filesystem.json'
    lip = require 'libraries.filesystem.lip'
    xml = require 'libraries.filesystem.xml'
    gamejolt = require 'libraries.utilities.gamejolt'
    discordrpc = require 'libraries.utilities.discordRPC'
    lollipop = require 'libraries.utilities.lollipop'
    terminal = require 'libraries.utilities.terminal'

    local Addons = love.filesystem.getDirectoryItems("libraries/addons")
    for addon = 1, #Addons, 1 do
        require("libraries.addons." .. string.gsub(Addons[addon], ".lua", ""))
    end

    -- ROOT Folder
    local root = love.filesystem.getInfo("root")
    if root == nil then
        love.filesystem.createDirectory("root")
    end

    -- state loader--
    local States = love.filesystem.getDirectoryItems("src/States")
    for state = 1, #States, 1 do
        require("src.States." .. string.gsub(States[state], ".lua", ""))
    end

    gamestate.registerEvents()
    gamestate.switch(playstate)
end
