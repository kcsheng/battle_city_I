class EnemyTank < Tank 
    def initialize
        @tank_west = Gosu::Image.new("../media/red_tank_west.png")
        @tank_east = Gosu::Image.new("../media/red_tank_east.png")
        @tank_north = Gosu::Image.new("../media/red_tank_north.png")
        @tank_south = Gosu::Image.new("../media/red_tank_south.png")
        @x = [20, 372, 724].sample
        @y = 10
        @head_west, @head_east, @head_north, @head_south = false, false, false, true
        @moving = false
        @first_move = true
    end

    def move  
        unless @moving            
            @time_stamp = Time.now 
            if @first_move # move away from the generation site.       
                @duration = 1.5
                @option = 3
                @first_move = false
            else                   
                @duration = rand * 1.7
                @option = [1, 2, 3].sample 
            end             
        end     
        if Time.now - @time_stamp <= @duration           
            case @option
            when 1; move_west
            when 2; move_east
            when 3; move_south
            end
            @moving = true
        else
            @moving = false
        end
    end

    def update
        move
    end
end

