class Player < Tank 
    attr_reader(:x, :y, :head_west, :head_east, :head_north, :head_south, :time_hit, :bricks)
    def initialize(window)
        @window = window
        # tank size (consistently square 56px)
        @tank_west = Gosu::Image.new("../media/blue_tank_west.png")
        @tank_east = Gosu::Image.new("../media/blue_tank_east.png")
        @tank_north = Gosu::Image.new("../media/blue_tank_north.png")
        @tank_south = Gosu::Image.new("../media/blue_tank_south.png")
        @x = 260
        @y = 644 
        @head_west, @head_east, @head_north, @head_south = false, false, true, false           
        @cannon = Cannon.new(self)
        @wall = Wall.new
        @bricks = @wall.bricks
        @wall_units = @wall.wall_units
        @enemyteam = EnemyTeam.new(self)
        @enemytanks = @enemyteam.enemy_team
        @explosion = Gosu::Image.load_tiles("../media/tank_explode.png", 72, 72)
        @alive = true
        @fort = Fort.new
    end

    def bomb(enemytanks)        
        enemytanks.each do |tank|
            if Gosu.distance(@cannon.x + 7.5, @cannon.y + 7.5, tank.x + 28, tank.y + 28) < 28
                @enemyteam.time_hit = Time.now # memorising the struck time
                @enemyteam.exploded = true # change the explosion status
                @enemyteam.loc_x = tank.x # memorising the struck location
                @enemyteam.loc_y = tank.y
                tank.alive = false
                @cannon.neutralised = true
                tank.cannon.neutralised = true
            end
        end
    end

    def bomb_by(enemytanks)
        enemytanks.each do |tank|
            if Gosu.distance(tank.cannon.x + 7.5, tank.cannon.y + 7.5, @x + 28, @y + 28) < 28
                @alive = false
                @window.game_running = false
                @cannon.neutralised = true
            end
        end
    end

    def sense_enemy
        unless @enemytanks.empty?
            nearest_tank = nearest_obj(@enemytanks)
        end
            sense_collide(nearest_tank)
    end

    def sense_brick
        unless @bricks.empty?
            nearest_brick = nearest_obj(@bricks)
        end
        sense_collide(nearest_brick)
    end

    def bomb_wall
        @wall_units.each do |unit| 
            if Gosu.distance(@cannon.x + 7.5, @cannon.y + 7.5, unit[1] + 20, unit[2] + 20) < 23
                @wall.brick_exploded = true
                @wall.time_struck = Time.now
                @wall.struck_x = unit[1]
                @wall.struck_y = unit[2]
                unit[0].exist = false
                @cannon.neutralised = true
            end
            @enemytanks.each do |tank|
                if Gosu.distance(tank.cannon.x + 7.5, tank.cannon.y + 7.5, unit[1] + 20, unit[2] + 20) < 23
                    @wall.brick_exploded = true
                    @wall.time_struck = Time.now
                    @wall.struck_x = unit[1]
                    @wall.struck_y = unit[2]
                    unit[0].exist = false
                    tank.cannon.neutralised = true
                end
            end
        end
    end

    def bomb_fort
        if Gosu.distance(@cannon.x + 7.5, @cannon.y + 7.5, @fort.x + 20, @fort.y + 20) < 30
            @fort.living = false
            @cannon.neutralised = true
            @window.game_running = false
        end
        @wall_units.each do |unit|
            @enemytanks.each do |tank|
                if Gosu.distance(tank.cannon.x + 7.5, tank.cannon.y + 7.5, @fort.x + 20, @fort.y + 20) < 30
                    @fort.living = false
                    @cannon.neutralised = true
                    @window.game_running = false
                end
            end
        end
    end

    def update
        case true # tank unable to move diagonally.
        when @window.button_down?(Gosu::Button::KbLeft); move_west
        when @window.button_down?(Gosu::Button::KbRight); move_east
        when @window.button_down?(Gosu::Button::KbUp); move_north
        when @window.button_down?(Gosu::Button::KbDown); move_south
        when @window.button_down?(Gosu::Button::KbSpace); @cannon.fire
        end
        @cannon.update
        @enemyteam.update
        bomb(@enemytanks)
        bomb_by(@enemytanks)
        sense_enemy
        sense_brick
        @wall.update
        bomb_wall
        bomb_fort
    end     
    
    def draw
        if @alive
            case true
            when @head_west; @tank_west.draw(@x, @y, 2)
            when @head_east; @tank_east.draw(@x, @y, 2)
            when @head_north; @tank_north.draw(@x, @y, 2)
            when @head_south; @tank_south.draw(@x, @y, 2)
            end
        else
            img = @explosion[Gosu::milliseconds / 100 % @explosion.size]
            img.draw(@x - 4, @y - 8, 2)        
        end
        @cannon.draw
        @enemyteam.draw
        @wall.draw
        @fort.draw
    end
end
