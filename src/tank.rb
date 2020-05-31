class Tank
    def move_west        
        @head_west, @head_east, @head_north, @head_south = true, false, false, false
        @x -= 1.5
        @x += 5 if @x < 0
        if @collide_obj_right
            @x += 5
            @collide_obj_right = false
        end
    end

    def move_east       
        @head_west, @head_east, @head_north, @head_south = false, true, false, false
        @x += 1.5
        @x -= 5 if @x + 56 > 800         
        if @collide_obj_left
            @x -= 5
            @collide_obj_left = false
        end
    end
    
    def move_north       
        @head_west, @head_east, @head_north, @head_south = false, false, true, false
        @y -= 1.5
        @y += 5 if @y < 0 
        if @collide_obj_bottom
            @y += 5
            @collide_obj_bottom = false
        end
    end

    def move_south       
        @head_west, @head_east, @head_north, @head_south = false, false, false, true
        @y += 1.5
        @y -= 5 if @y + 56 > 710 
        if @collide_obj_top
            @y -= 5
            @collide_obj_top = false
        end
    end 

    def nearest_obj(objects)
        distances = []
        centre_loc = 20 if objects[0].class == Brick # centre location of brick
        centre_loc = 28 if objects[0].class.superclass == Tank
        objects.each { |obj| distances << Gosu.distance(obj.x + centre_loc, obj.y + centre_loc, @x + 28, @y + 28) }
        distances.delete(0) # not including self in team situation
        nearest_obj_index = distances.index(distances.min)
        objects[nearest_obj_index]    
    end

    def sense_collide(obj)
        unless obj.nil?
            ox = obj.x
            oy = obj.y
            ow = oh = 40 if obj.class == Brick # obj width and height
            ow = oh = 56 if obj.class.superclass == Tank
            if oy + oh > @y && oy < @y + 56 && ox < @x && ox + ow > @x
                @collide_obj_right = true 
                @x += 1 # remove from intersection instantly to avoid brick stickiness
            end

            if oy + oh > @y && oy < @y + 56 && ox < @x + 56 && ox + ow > @x + 56
                @collide_obj_left = true
                @x -= 1
            end

            if ox + ow > @x && ox < @x + 56 && oy < @y && oy + oh > @y
                @collide_obj_bottom = true
                @y += 1
            end

            if ox + ow > @x && ox < @x + 56 && oy < @y + 56 && oy + oh > @y + 56
                @collide_obj_top = true
                @y -= 1
            end 
        end
    end
end