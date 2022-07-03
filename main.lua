local logic = require("lib.logic")
require('lib.entity')
local width = 0
local height = 0

function love.load()
   logic:init()
   logic:set(1, 3, 1)
   logic:set(2, 3, 3)
   logic:set(3, 3, 3)
   logic:set(4, 3, 3)
   logic:set(5, 2, 3)
   logic:set(5, 4, 3)
   logic:set(6, 2, 3)
   logic:set(6, 4, 3)
   logic:set(7, 3, 3)
   logic:set(8, 3, 3)
   logic:set(9, 3, 3)
   logic:add_entity(4,4, new_constant_note_entity(48))
   width = love.graphics.getWidth( )
   height = love.graphics.getHeight( )
   stepX = width/16
   stepY = height/16
end

function love.draw()
   for x = 1, 16 do
      for y = 1, 16 do
         if logic.cells[x][y] == 1 then
            love.graphics.setColor(0, 0, 1)
         elseif logic.cells[x][y] == 0 then
            love.graphics.setColor(0, 0, 0)
         elseif logic.cells[x][y] == 2 then
            love.graphics.setColor(1, 0, 0)
         elseif logic.cells[x][y] == 3 then
            love.graphics.setColor(1, 1, 0)
         end
         love.graphics.rectangle("fill", (x - 1) * stepX, (y - 1) * stepY, stepX, stepY)
      end
   end
end

local dtotal = 0

function love.update(dt)
   dtotal = dtotal + dt
   if dtotal >= 1 then
      dtotal = dtotal - 1 
      logic:update()
   end
end
