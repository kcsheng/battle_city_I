class Player < Tank 
    attr_reader(:x, :y, :head_west, :head_east, :head_north, :head_south, :time_hit, :bricks, :win, :lives)
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
        @fort = Fort.new
        @bombed_tank = 0
        @win = false
        @hit_brick = Gosu::Sample.new("../media/distant_explosion.mp3")
        @hit_tank = Gosu::Sample.new("../media/tank_explosion.mp3")
        @lives = 3
        @exploded = false
        @time_hit = nil
        @loc_x = 0
        @loc_y = 0
        @text_display = Gosu::Font.new(@window,"FUTURA", 50)
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
                @bombed_tank += 1
                @hit_tank.play
            end
        end
    end

    def bomb_by(enemytanks)
        enemytanks.each do |tank|
            if Gosu.distance(tank.cannon.x + 7.5, tank.cannon.y + 7.5, @x + 28, @y + 28) < 28
                @cannon.neutralised = true
                tank.cannon.neutralised = true
                @hit_tank.play
                @exploded = true
                @time_hit = Time.now
                @loc_x = @x
                @loc_y = @y                              
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

    def events_after(cannon, unit)
        @wall.brick_exploded = true
        @wall.time_struck = Time.now
        @wall.struck_x = unit[1]
        @wall.struck_y = unit[2]
        unit[0].exist = false
        cannon.neutralised = true
        @hit_brick.play
    end

    def bomb_wall
        @wall_units.each do |unit|             
            if Gosu.distance(@cannon.x + 7.5, @cannon.y + 7.5, unit[1] + 20, unit[2] + 20) < 23
                events_after(@cannon, unit)
            end
            @enemytanks.each do |tank|
                if Gosu.distance(tank.cannon.x + 7.5, tank.cannon.y + 7.5, unit[1] + 20, unit[2] + 20) < 23
                    events_after(tank.cannon, unit)
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

    def win_lose_state
        if @enemytanks.length == 0 && @bombed_tank == 50
            @win = true
            @window.game_running = false
        end
        if @lives == 0 
            @window.game_running = false
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
        win_lose_state
    end     
    
    def draw        
        if @exploded
            img = @explosion[Gosu::milliseconds / 100 % @explosion.size]            
            img.draw(@loc_x - 8, @loc_y - 8, 2)
            if @lives > 0 && Time.now - @time_hit > 0.5
                @exploded = false
                @lives -= 1
                @x = 260
                @y = 644
            end            
        elsif @lives > 0 && @exploded == false
            case true
            when @head_north; @tank_north.draw(@x, @y, 2)
            when @head_west; @tank_west.draw(@x, @y, 2)
            when @head_east; @tank_east.draw(@x, @y, 2)
            when @head_south; @tank_south.draw(@x, @y, 2)
            end
        end
        @text_display.draw_text("LIVES: #{@lives}", 10, 670, 3, 0.8, 0.8, Gosu::Color::GREEN)
        @cannon.draw
        @enemyteam.draw
        @wall.draw
        @fort.draw
    end
end
