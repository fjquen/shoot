require 'gosu'

class Ending
    def initialize
        @font = Gosu::Font.new(20)
    end

    def draw
        @font.draw_text("c'est fini bravo", 10, 10, 0, 1.0, 1.0, Gosu::Color::YELLOW)
    end
end