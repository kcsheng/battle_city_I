class Tank
    def initialize
        # tank size (consistently square 56px)
        @tank_west = Gosu::Image.new("../media/blue_tank_west.png")
        @tank_east = Gosu::Image.new("../media/blue_tank_east.png")
        @tank_north = Gosu::Image.new("../media/blue_tank_north.png")
        @tank_south = Gosu::Image.new("../media/blue_tank_south.png")
        @x = 260
        @y = 644 
        @mov_west, @mov_east, @mov_north, @mov_south = false, false, false, false
        @left, @right, @top, @bottom = @x, @x + 56, @y, @y + 56
    end

    # def move        
    #     if @mov_west
    #         @x -= 1 
    #         if @left < 0   
    #             @x += 5
    #         end
    #     end
        
    #     if @mov_east 
    #         @x += 1 
    #         if @right > 800
    #             @x -= 5
    #         end
    #     end

    #     if @mov_north             
    #         @y -= 1 
    #         if @top < 0
    #             @y += 5
    #         end
    #     end

    #     if @mov_south 
    #         @y += 1 
    #         if @bottom > 710
    #             @y -= 5
    #         end
    #     end
    # end

    def update
        move
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
