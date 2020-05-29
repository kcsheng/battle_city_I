class GameWindow < Gosu::Window
    def initialize
        super(800, 710, false)
        self.caption = "Battle City I"
        @player = Player.new(self)
    end

    def button_down(id)
        if id == Gosu::KB_ESCAPE
            close
        end
    end    
    
    def update
        @player.update
    end

    def draw
        @player.draw
    end    
end