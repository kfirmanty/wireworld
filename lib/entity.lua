function direct_neighbours(cells, x, y, of_type)
   local count = 0
   for xt=x-1, x+1 do
      if xt ~= x
         and xt>=1 and xt <= #cells
         and cells[xt][y] == of_type then
         count = count + 1
      end
   end

   for yt=y-1, y+1 do
      if yt ~= y
         and yt>=1 and yt <= #(cells[x])
         and cells[x][yt] == of_type then
         count = count + 1
      end
   end
   return count
end

function new_constant_note_entity(value)
   local entity = {note = value}
   function entity:update(cells, x, y)
      local head_count = direct_neighbours(cells, x, y, 1)
      if head_count > 0 then
         for i=1, head_count do
            print("CONSTANT NOTE: " .. self.note .. "\n")
         end
      end
   end
   return entity
end
