class GameWindow < Gosu::Window
    attr_accessor(:game_running)
    def initialize
        super(800, 710, false)
        self.caption = "Battle City I"
        @text_display = Gosu::Font.new(self, "FUTURA", 50)
        @theme_music = Gosu::Song.new("../media/magic_space.mp3")
        @theme_music.play(true)
        @theme_music.volume = 0.4
        @game_over_music = Gosu::Song.new("../media/game_over.wav")
        @game_over_music.volume = 0.5
        @player = Player.new(self)
        @game_running = true
        @game_over_music_played = false
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
            @theme_music.pause
            unless @game_over_music_played 
                @game_over_music.play 
                @game_over_music_played = true
            end         
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