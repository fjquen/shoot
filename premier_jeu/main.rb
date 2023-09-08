require 'gosu'
require './move_game.rb'
require './beam.rb'

class Main < Gosu::Window
    include Move_game
    include Beam

    def initialize
        super 640,480
        self.caption = "premier jeu"
        @area_combat = [[" "," "," "," "," "," "," "," "," "," "," ",],
                        [" "," "," "," "," "," ","°"," "," "," "," ",],
                        [" "," "," "," "," "," ","°"," "," "," "," ",],
                        [" "," "," "," "," "," "," "," "," "," "," ",],
                        [" "," "," "," "," "," "," "," "," "," "," ",],
                        [" "," "," "," "," "," "," "," "," "," "," ",],
                        [" "," "," "," "," "," "," "," "," "," "," ",],
                        [" "," "," "," ","§"," "," "," "," "," "," ",]]
        @player = Gosu::Image.new("media/playerShip1_blue.png")
        @ennemy = Gosu::Image.new("media/enemyRed1.png")
        @beam = Gosu::Image.new("media/laserRed05.png")
        @x=@y=@y_push=0
    end
    
    def update
        
    end

    def button_down(id)
        case id
        when Gosu::KB_RIGHT,Gosu::GP_RIGHT
            move_right_player()
        when Gosu::KB_LEFT,Gosu::GP_LEFT
            move_left_player()
        when Gosu::KB_SPACE,Gosu::GP_BUTTON_1
            move_beam(PLAYER,VOID,ENNEMY)
        end
    end
   
    def draw
       draw_area()
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
                    Gosu.draw_rect(x*WIDTH_TILE+POSITION_BEAM, y*HEIGHT_TILE, WIDTH_TILE_BEAM, HEIGHT_TILE_BEAM,Gosu::Color::RED)
                    pos_row_player = @area_combat.flatten.index(BEAM)
                    pos_col_player = @area_combat.first.size
                    row_player = pos_row_player / pos_col_player
                    col_player = pos_row_player % pos_col_player
                    @y = row_player
                    @y -= 1
                    return if @area_combat[@y_push][x] == ENNEMY
                            @area_combat[@y_push][x],@area_combat[y][x] = @area_combat[y][x],@area_combat[@y_push][x]
                end
            end 
        end
    end
end
Main.new.show