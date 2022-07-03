require("lib.helpers")
local logic = {cells = {},
               entities = {}}
local board_width = 16;
local board_height = 16;

-- 0 empty
-- 1 electron head
-- 2 electron tail
-- 3 conductor
function logic:init()
   for x=1,board_width do
      self.cells[x] = {}
      self.entities[x] = {}
      for y=1,board_height do
         self.cells[x][y] = 0
         self.entities[x][y] = nil
      end
   end
end

function logic:neighbours(x, y, of_type)
   local count = 0
   for xt=x-1, x+1 do
      for yt=y-1, y+1 do
         if not (xt == x and yt == y)
            and xt>=1 and xt <= board_width
            and yt >=1 and yt <= board_height
            and self.cells[xt][yt] == of_type then
            count = count + 1
         end
      end
   end
   return count
end

function logic:update()
   local new_cells = {}
   for x=1,board_width do
      new_cells[x] = {}
      for y=1,board_height do
         new_cells[x][y] = 0
      end
   end
   for x=1,board_width do
      for y=1,board_height do
         if self.cells[x][y] == 0 then
            new_cells[x][y] = 0
         elseif self.cells[x][y] == 1 then
            new_cells[x][y] = 2
         elseif self.cells[x][y] == 2 then
            new_cells[x][y] = 3
         elseif self.cells[x][y] == 3 then
            local near_heads = self:neighbours(x, y, 1)
            if(near_heads == 1 or near_heads == 2) then
               new_cells[x][y] = 1
            else
               new_cells[x][y] = 3
            end
         end
         local entity = self.entities[x][y]
         if entity then entity:update(self.cells, x, y) end
      end
   end
   self.cells = new_cells;
end

function logic:set(x, y, val)
   self.cells[x][y] = val
end

function logic:add_entity(x, y, entity)
   self.entities[x][y] = entity
end

return logic
