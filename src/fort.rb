class Fort
    attr_reader(:x, :y)
    attr_accessor(:living)
    def initialize
        @fort_alive = Gosu::Image.load_tiles("../media/fort.png", 60, 60)
        @fort_destroyed = Gosu::Image.new("../media/fort_explosion.png")
        @x = 370
        @y = 640
        @living = true
    end

    def draw
        if @living
            img = @fort_alive[Gosu::milliseconds / 80 % @fort_alive.size]
            img.draw(@x, @y, 0)
        else
            @fort_destroyed.draw(360, 630, 1)
        end
    end
end