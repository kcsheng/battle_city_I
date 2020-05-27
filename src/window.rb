class GameWindow < Gosu::Window
    def initialize
        super(800, 710, false)
        self.caption = "Battle City I"
        @tank = Tank.new
    end

    def button_down(id)
        if id == Gosu::KB_ESCAPE
            close
        else
          super
        end
    end
    
    def update
        @tank.update
    end

    def draw
        @tank.draw
    end    
end