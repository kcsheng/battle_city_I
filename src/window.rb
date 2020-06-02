class GameWindow < Gosu::Window
    attr_accessor(:game_running)
    def initialize
        super(800, 710, false)
        self.caption = "Battle City I"
        @text_display = Gosu::Font.new(self, "FUTURA", 50)
        @music = Gosu::Song.new("../media/magic_space.mp3")
        @music.play(true)
        @music.volume = 0.1
        @player = Player.new(self)
        @game_running = true
    end

    def button_down(id)
        if id == Gosu::KB_ESCAPE
            close
        end
    end    
    
    def update
        if @game_running
            @player.update
        else 
            @music.pause 
        end
    end

    def draw
        @player.draw
        unless @game_running
            if @player.win
                @text_display.draw_text("You Won!", 300, 305, 3, 1, 1, Gosu::Color::CYAN)
            else
                @text_display.draw_text("Game Over", 296, 305, 3, 1, 1, Gosu::Color::CYAN)
            end
        end 
    end    
end