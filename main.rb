require 'gosu'
require './constant.rb'
require './move_game.rb'
require './beam.rb'

class Main < Gosu::Window
    include Constant
    include Move_game
    include Beam

    def initialize
        super 640,480
        self.caption = "Shoot"
        @area_combat = [[" "," "," "," "," "," "," "," "," "," "," ",],
                        [" "," "," "," "," "," "," "," "," "," "," ",],
                        [" "," ","°"," "," "," "," ","°"," "," "," ",],
                        [" "," "," "," "," "," "," "," "," "," "," ",],
                        [" "," "," "," "," "," "," "," ","°"," "," ",],
                        [" "," "," "," "," "," "," "," "," "," "," ",],
                        [" "," ","°"," "," "," "," "," "," "," "," ",],
                        [" "," "," "," ","§"," "," "," "," "," "," ",]]
        @player = Gosu::Image.new("media/playerShip1_blue.png")
        @ennemy = Gosu::Image.new("media/enemyRed1.png")
        @x=@y=0
        @font = Gosu::Font.new(20)
        @tab_move_ennemy = ["r","l","s","b"]
        self.update_interval = 100
        @background_image = Gosu::Image.new("media/space.png", :tileable => true)
        @count_life = 3
    end
    
    def update
       @number_ennemy = @area_combat.flatten.select { |n| n == ENNEMY }.length
       @number_player = @area_combat.flatten.select { |n| n == PLAYER }.length
       move_again_player()
       move_ennemy()
       end_level()
    end

    def button_down(id)
        case id
            when Gosu::KB_RIGHT,Gosu::GP_RIGHT
                move_right_player()
            when Gosu::KB_LEFT,Gosu::GP_LEFT
                move_left_player()
            when Gosu::KB_SPACE,Gosu::GP_BUTTON_1
                move_beam()
            when Gosu::KB_ESCAPE
                close
        end
    end
   
    def draw
       draw_area()
       draw_text
       @background_image.draw(0, 0, 0)
    end

    def draw_area()
        @area_combat.each_index do |y|
            @area_combat[y].each_index do |x|
                if @area_combat[y][x] == VOID
                    Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::BLACK)
                elsif @area_combat[y][x] == PLAYER
                    @player.draw(x*WIDTH_TILE, y*HEIGHT_TILE,1)
                elsif @area_combat[y][x] == ENNEMY
                    @ennemy.draw(x*WIDTH_TILE, y*HEIGHT_TILE,1)
                elsif @area_combat[y][x] == BEAM
                    Gosu.draw_rect(x*WIDTH_TILE+POSITION_BEAM, y*HEIGHT_TILE, WIDTH_TILE_BEAM, HEIGHT_TILE_BEAM,Gosu::Color::RED,1)
                    @area_combat[y][x] = VOID
                end
            end 
        end
    end

    def draw_text
        @font.draw_text("Nombre d'ennemy à eliminey : #{ @number_ennemy}", 10, 10, 1, 1.0, 1.0, Gosu::Color::YELLOW)
        @font.draw_text("Nombre de vie héro : #{ @count_life}", 450, 10, 1, 1.0, 1.0, Gosu::Color::YELLOW)
    end

    def end_level
         if @count_life == 0
            close
         end
    end
end
Main.new.show