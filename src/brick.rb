class Brick
    attr_reader(:brick, :exist)
    attr_accessor(:x, :y)
    def initialize
        # All bricks are 40px by 40px
        @brick = Gosu::Image.new("../media/brick.png")
        @exist = true   
    end
end