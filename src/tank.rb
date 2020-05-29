class Tank
    def move_west        
        @head_west, @head_east, @head_north, @head_south = true, false, false, false
        @x -= 1
        @x += 5 if @x < 0 
    end

    def move_east       
        @head_west, @head_east, @head_north, @head_south = false, true, false, false
        @x += 1 
        @x -= 5 if @x + 56 > 800    
    end
    
    def move_north       
        @head_west, @head_east, @head_north, @head_south = false, false, true, false
        @y -= 1
        @y += 5 if @y < 0   
    end

    def move_south       
        @head_west, @head_east, @head_north, @head_south = false, false, false, true
        @y += 1 
        @y -= 5 if @y + 56 > 710      
    end 
end