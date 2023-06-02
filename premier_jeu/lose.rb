require 'gosu'

class Lose
    def initialize
        @font = Gosu::Font.new(20)
    end

    def draw
        
        @font.draw_text("c'est perdu", 10, 10, 0, 1.0, 1.0, Gosu::Color::YELLOW)
    end
end