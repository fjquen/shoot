require './constant.rb'

module Draw_game
    include Constant

    def draw_area()
        @arr.each_index do |y|
            @arr[y].each_index do |x|
                if @arr[y][x] == VOID
                    Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::BLACK)
                elsif @arr[y][x] == PLAYER
                    @player.draw(x*WIDTH_TILE, y*HEIGHT_TILE,1)
                elsif @arr[y][x] == ENNEMY
                    @ennemy.draw(x*WIDTH_TILE, y*HEIGHT_TILE,1)
                elsif @arr[y][x] == BEAM
                    Gosu.draw_rect(x*WIDTH_TILE+POSITION_BEAM, y*HEIGHT_TILE, WIDTH_TILE_BEAM, HEIGHT_TILE_BEAM,Gosu::Color::RED,1)
                    @arr[y][x] = VOID
                end
            end 
        end
    end

    def draw_text
        @font.draw_text("Nombre d'ennemy à eliminer : #{ @number_ennemy}", 10, 10, 1, 1.0, 1.0, Gosu::Color::YELLOW)
        @font.draw_text("Nombre de vie player : #{ @count_life}", 420, 10, 1, 1.0, 1.0, Gosu::Color::YELLOW)
    end

    def draw_game_over
         if @count_life == 0
            @arr.clear
            @font.draw_text("Tu as perdu mais tu peux recommencer appuie sur R", 85, 205, 1, 1, 1, Gosu::Color::YELLOW)
         end
    end

    def draw_game_end
        @arr.clear
        @font.draw_text("Tu as fini le jeu, tu as gagné !\nTu peux quitter le jeu en appuyant sur le bouton ECHAP", 85, 205, 1, 1, 1, Gosu::Color::YELLOW)
    end

end