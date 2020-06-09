class Wall
    attr_reader(:wall_units, :bricks)
    attr_accessor(:brick_exploded, :time_struck, :struck_x, :struck_y)
    def initialize
        @bricks = 64.times.map { Brick.new }
        @all_brick_x = (100..300).step(40).to_a + (460..660).step(40).to_a + (280..480).step(40).to_a + 
        (0..280).step(40).to_a + (480..760).step(40).to_a + (240..520).step(40).to_a +
        (0..200).step(40).to_a + (360..400).step(40).to_a + (560..760).step(40).to_a + 
        (320..440).step(40).to_a + [320] + [440] + [320] + [440]
        @all_brick_y = [90] * 12 + [200] * 6 + [310] * 16 + [420] * 8 + [530] * 6 + [460] * 2 + [530] * 6 + [590] * 4 + 
        [630] * 2 + [670] * 2
        @wall_units = []
        (0..63).each { |n| @wall_units.push([@bricks[n]] << @all_brick_x[n] << @all_brick_y[n]) } # pack each brick profile into wall 
        (0..63).each { |n| @wall_units[n][0].x = @wall_units.assoc(@wall_units[n][0])[1] } # write all brick instance :x 
        (0..63).each { |n| @wall_units[n][0].y = @wall_units.assoc(@wall_units[n][0])[2] } # write all brick instance :y
        @struck = false
        @brick_explosion = Gosu::Image.load_tiles("../media/brick_explode.png", 50, 50)
        @brick_exploded = false
        @time_struck = nil
    end    

    def check_exist
        @bricks.select! { |brick| brick.exist }
        @wall_units.select! { |element| element[0].exist }
    end

    def update
        check_exist
    end

    def draw
        @wall_units.each do |brick|
            brick[0].brick.draw(brick[1], brick[2], 0)
        end
        if @brick_exploded   # Show the brick explosion    
            img = @brick_explosion[Gosu::milliseconds / 25 % @brick_explosion.size]
            img.draw(@struck_x - 5, @struck_y - 5, 2) # Minus is for adjusting the explosion image
            if Time.now - @time_struck > 0.5
                @brick_exploded = false
            end
        end
    end
end