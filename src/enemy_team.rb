class EnemyTeam    
    def initialize
        @game_start = Time.now
        @generating_tank = false
        @enemy_team = []
        @count = 0
    end

    def generate_tank
        @tank = EnemyTank.new
        @enemy_team << @tank
    end

    def generate_tank_timer(sec)
        @game_duration =  (Time.now - @game_start).to_i
        @r = @game_duration % sec
        if @r == 0 && @generating_tank == false
            generate_tank
            @generating_tank = true
        end
        if @r != 0
            @generating_tank = false
        end
    end

    def update
        generate_tank_timer(3)
        @enemy_team.each do |tank|
            tank.update
        end
    end

    def draw
        @enemy_team.each do |tank|
            tank.draw
        end
    end
end