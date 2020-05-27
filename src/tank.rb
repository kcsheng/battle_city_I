class Tank
    def initialize
        # tank size (consistently square 56px)
        @tank_west = Gosu::Image.new("../media/blue_tank_west.png")
        @tank_east = Gosu::Image.new("../media/blue_tank_east.png")
        @tank_north = Gosu::Image.new("../media/blue_tank_north.png")
        @tank_south = Gosu::Image.new("../media/blue_tank_south.png")
        @x = 260
        @y = 644 
        @mov_west, @mov_east, @mov_north, @mov_south = [false] * 4
    end

    def move_west        
        @mov_west, @mov_east, @mov_north, @mov_south = true, false, false, false
        @x -= 1
        @x += 5 if @x < 0 
    end

    def move_east       
        @mov_west, @mov_east, @mov_north, @mov_south = false, true, false, false
        @x += 1  
        @x -= 5 if @x + 56 > 800    
    end
    
    def move_north       
        @mov_west, @mov_east, @mov_north, @mov_south = false, false, true, false
        @y -= 1
        @y += 5 if @y < 0   
    end

    def move_south       
        @mov_west, @mov_east, @mov_north, @mov_south = false, false, false, true
        @y += 1 
        @y -= 5 if @y + 56 > 710      
    end

    def update
        move_south
    end

    def draw
        case true
        when @mov_west; @tank_west.draw(@x, @y, 1)
        when @mov_east; @tank_east.draw(@x, @y, 1)
        when @mov_north; @tank_north.draw(@x, @y, 1)
        when @mov_south; @tank_south.draw(@x, @y, 1)
        end
    end
end
