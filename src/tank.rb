class Tank
    def move_west        
        @head_west, @head_east, @head_north, @head_south = true, false, false, false
        @x -= 1.5
        @x += 5 if @x < 0 || @collide_obj_right
    end

    def move_east       
        @head_west, @head_east, @head_north, @head_south = false, true, false, false
        @x += 1.5
        @x -= 5 if @x + 56 > 800 || @collide_obj_left
    end
    
    def move_north       
        @head_west, @head_east, @head_north, @head_south = false, false, true, false
        @y -= 1.5
        @y += 5 if @y < 0 || @collide_obj_bottom   
    end

    def move_south       
        @head_west, @head_east, @head_north, @head_south = false, false, false, true
        @y += 1.5
        @y -= 5 if @y + 56 > 710 || @collide_obj_top   
    end 

    def nearest_obj(objects)
        distances = []
        # centre_loc = 20 if obj.class == Brick # obj width and height
        centre_loc = 28 if objects[0].class.superclass == Tank
        objects.each { |obj| distances << Gosu.distance(obj.x + centre_loc, obj.y + centre_loc, @x + 28, @y + 28) }
        nearest_obj_index = distances.index(distances.min)
        objects[nearest_obj_index]    
    end

    def sense_collide(obj)
        @collide_obj_left, @collide_obj_right, @collide_obj_top, @collide_obj_bottom = [false] * 4
        ox = obj.x
        oy = obj.y
        # ow = oh = 40 if obj.class == Brick # obj width and height
        ow = oh = 56 if obj.class.superclass == Tank
        if oy + oh > @y && oy < @y + 56 && ox < @x && ox + ow > @x
            @collide_obj_right = true
            @x += 1 # remove tank from intersection 
        end

        if oy + oh > @y && oy < @y + 56 && ox < @x + 56 && ox + ow > @x + 56
            @collide_obj_left = true
            @x -= 1 # remove tank from intersection 
        end

        if ox + ow > @x && ox < @x + 56 && oy < @y && oy + oh > @y
            @collide_obj_bottom = true
            @y += 1 # remove tank from intersection
        end

        if ox + ow > @x && ox < @x + 56 && oy < @y + 56 && oy + oh > @y + 56
            @collide_obj_top = true
            @y -= 1 # remove tank from intersection 
        end 
    end
end