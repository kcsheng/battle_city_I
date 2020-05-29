class Player < Tank 
    attr_reader(:x, :y, :head_west, :head_east, :head_north, :head_south)
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
    end     
    
    def draw
        case true
        when @head_west; @tank_west.draw(@x, @y, 1)
        when @head_east; @tank_east.draw(@x, @y, 1)
        when @head_north; @tank_north.draw(@x, @y, 1)
        when @head_south; @tank_south.draw(@x, @y, 1)
        end
        @cannon.draw
    end
end
