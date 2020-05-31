class EnemyTeam 
    attr_reader(:enemy_team, :player) 
    attr_accessor(:time_hit, :loc_x, :loc_y, :exploded)  
    def initialize(player)
        @player = player
        @game_start = Time.now
        @generating_tank = false
        @enemy_team = []
        @count = 0 
        @explosion = Gosu::Image.load_tiles("../media/tank_explode.png", 72, 72) 
        @exploded = false
        @time_hit = nil             
    end

    def generate_tank
        @tank = EnemyTank.new(self)
        @enemy_team << @tank
        p @count += 1
    end

    def generate_tank_timer(sec)
        @game_duration = (Time.now - @game_start).to_i
        @r = @game_duration % sec
        if @r == 0 && @generating_tank == false
            generate_tank
            @generating_tank = true
        end
        if @r != 0
            @generating_tank = false
        end
    end

    def select_alive
        @enemy_team.select! { |tank| tank.alive }
    end

    def update
        generate_tank_timer(2)
        select_alive # only show live tanks
        @enemy_team.each { |tank| tank.update }
    end

    def draw        
        @enemy_team.each { |tank| tank.draw }
        if @exploded   # Show the dead tank explosion    
            img = @explosion[Gosu::milliseconds / 40 % @explosion.size]
            img.draw(@loc_x, @loc_y, 2)
            if Time.now - @time_hit > 0.5
                @exploded = false
            end
        end
    end
end