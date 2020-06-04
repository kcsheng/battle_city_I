class EnemyTank < Tank 
    attr_reader(:x, :y, :head_west, :head_east, :head_north, :head_south, :cannon)
    attr_accessor(:alive)
    def initialize(team)
        @tank_west = Gosu::Image.new("../media/red_tank_west.png")
        @tank_east = Gosu::Image.new("../media/red_tank_east.png")
        @tank_north = Gosu::Image.new("../media/red_tank_north.png")
        @tank_south = Gosu::Image.new("../media/red_tank_south.png")
        @x = [20, 372, 724].sample
        @y = 10
        @head_west, @head_east, @head_north, @head_south = false, false, false, true
        @moving = false
        @first_move = true
        @cannon = Cannon.new(self)
        @game_start = Time.now
        @cannon_active = false
        @cannon_fired = false
        @alive = true   
        @team = team 
        @teammates = @team.enemy_team
        @player = @team.player      
    end

    def move  
        unless @moving            
            @time_stamp = Time.now 
            if @first_move # move away from the generation site.       
                @duration = 1.5
                @option = 3
                @first_move = false
            else                   
                @duration = rand * 1.5
                @option = [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3].sample 
            end             
        end     
        if Time.now - @time_stamp <= @duration           
            case @option
            when 1; move_west
            when 2; move_east
            when 3; move_south
            when 4; move_north
            end
            @moving = true
        else
            @moving = false
        end
    end

    def cannon_timer(range)
        unless @cannon_active 
            @get_time = Time.now
            @game_duration = (@get_time - @game_start).to_i
            @num = rand(range)
            @r = @game_duration % @num if @game_duration > 1 # fire once within num seconds, but not right at the start
        end
        if @r == 0 && @cannon_fired == false
            @cannon_active = true
            @cannon.fire
            @cannon_fired = true
        end
        if Time.now - @get_time > @num
            @cannon_active = false
            @cannon_fired = false
        end
    end

    def sense_teammate
        if @teammates.length >= 2 # need at least 2 teammates 
            nearest_tank = nearest_obj(@teammates)
            sense_collide(nearest_tank)
        end
    end

    def sense_brick
        unless @player.bricks.empty?
            nearest_brick = nearest_obj(@player.bricks)
        end
        sense_collide(nearest_brick)
    end

    def update
        move
        @cannon.update
        cannon_timer(4..8)
        sense_collide(@player)
        sense_teammate
        sense_brick
    end

    def draw           
        case true
        when @head_west; @tank_west.draw(@x, @y, 1)
        when @head_east; @tank_east.draw(@x, @y, 1)
        when @head_north; @tank_north.draw(@x, @y, 1)
        when @head_south; @tank_south.draw(@x, @y, 1)
        end 
        @cannon.draw
    end
end

