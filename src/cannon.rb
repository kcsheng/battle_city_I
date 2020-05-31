class Cannon
    attr_reader(:launched, :launch, :x, :y, :wall)
    attr_accessor(:neutralised)
    def initialize(driver)
        @driver = driver
        @cannon_ball = Gosu::Image.new("../media/blueball.png") if @driver.class == Player 
        @cannon_ball = Gosu::Image.new("../media/orangeball.png") if @driver.class == EnemyTank
        @x = @driver.x + 20.5
        @y = @driver.y + 20.5
        @launch = false
        @launched = false
        @west, @east, @north, @south = [false] * 4
        @neutralised = false
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
            if @y < 0 || @x < 0 || @y > 710 || @x > 800 || @neutralised
                @launch = false  # turn off the cannon launch path
                @neutralised = false
            end
        else
            @launched = false # reload the cannon
            @x = @driver.x + 20.5  
            @y = @driver.y + 20.5          
        end
    end

    def draw
        unless @neutralised
            @cannon_ball.draw(@x, @y, 2)
        end
    end
end