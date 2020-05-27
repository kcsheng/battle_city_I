class GameWindow < Gosu::Window
    def initialize
        super(800, 710, false)
        self.caption = "Battle City I"
    end

    def button_down(id)
        if id == Gosu::KB_ESCAPE
            close
        else
          super
        end
    end
end