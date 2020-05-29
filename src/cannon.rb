class Cannon
    attr_reader(:launched, :launch)
    def initialize(driver)
        @driver = driver
        @cannon_ball = Gosu::Image.new("../media/cannonball.png")
        @x = @driver.x + 20.5
        @y = @driver.y + 20.5
        @launch = false
        @launched = false
        @west, @east, @north, @south = [false] * 4
    end

    def fire
        unless @launched
            @launch = true
            case true
            when @driver.head_west; @west, @east, @north, @south = true, false, false, false
            when @driver.head_east; @west, @east, @north, @south = false, true, false, false
            when @driver.head_north; @west, @east, @north, @south = false, false, true, false
            when @driver.head_south; @west, @east, @north, @south = false, false, false, true 
            end           
        end        
    end

    def update
        if @launch
            @launched = true
            case true
            when @west; @x -= 4
            when @east; @x += 4
            when @north; @y -= 4
            when @south; @y += 4
            end
            if @y < 0 || @x < 0 || @y > 710 || @x > 800
                @launch = false  # turn off the cannon launch path
            end
        else
            @launched = false # reload the cannon
            @x = @driver.x + 20.5  
            @y = @driver.y + 20.5          
        end
    end

    def draw
        @cannon_ball.draw(@x, @y, 0)
    end
end