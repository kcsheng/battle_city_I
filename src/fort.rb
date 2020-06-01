class Fort
    def initialize
        @fort_alive = Gosu::Image.load_tiles("../media/fort.png", 60, 60)
        @fort_destroyed = Gosu::Image.new("../media/blue_explosion.png")
        @x = 640
        @y = 370
        @living = true
    end

    def draw
        img = @fort_alive[Gosu::milliseconds / 80 % @fort_alive.size]
        img.draw(@x, @y, 0)
    end
end