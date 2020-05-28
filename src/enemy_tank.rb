class EnemyTank < Tank 
    def initialize
        @tank_west = Gosu::Image.new("../media/red_tank_west.png")
        @tank_east = Gosu::Image.new("../media/red_tank_east.png")
        @tank_north = Gosu::Image.new("../media/red_tank_north.png")
        @tank_south = Gosu::Image.new("../media/red_tank_south.png")
        @x = [20, 372, 724].sample
        @y = 10
        @head_west, @head_east, @head_north, @head_south = false, false, false, true
        @time_stamp = Time.now
        @moving = false
        @instruct_given = true
    end

    def move           
        if Time.now - @time_stamp <= 1 
            move_south
            @moving = true
            if Time.now - @time_stamp == 1 # Turn off the entire if evaluation.
                @moving = false
                @instruct_given = false
            end
        end
        unless @moving_instruct        
            duration = rand * 1.7
            option = [1, 2, 3].sample
            time_start = Time.now 
            @moving_instruct = true     
        end
            
        if @moving == false 
        if Time.now - time_start <= duration
            case option
            when 1; move_west
            when 2; move_east
            when 3; move_south
            end
        else            
            @instruct_given = false
        end
    end

    def update
        move
    end
end

