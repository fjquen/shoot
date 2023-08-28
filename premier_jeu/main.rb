require 'gosu'


class Main < Gosu::Window
    PLAYER = "§"
    ENNEMY = "°"
    VOID = " "
    WIDTH_TILE = 55
    HEIGHT_TILE = 55
    WIDTH_TILE_PLAYER = 65
    HEIGHT_TILE_PLAYER = 65

    def initialize
        super 640,480
        self.caption = "premier jeu"
        @area_combat = [[" "," "," "," "," "," "," "," "," ",],
                        [" ","°"," "," "," "," ","°"," "," ",],
                        [" "," "," ","°"," "," "," "," "," ",],
                        [" ","°"," "," "," "," "," "," "," ",],
                        [" "," "," "," "," "," "," "," "," ",],
                        [" "," "," "," "," "," "," "," "," ",],
                        ["§"," "," "," "," "," "," "," "," ",]]
        @player = Gosu::Image.new("media/playerShip1_blue.png")
    end
    
    def update
        
    end
   
    def draw
       draw_area
    end

    def draw_area
        @area_combat.each_index do |y|
            @area_combat[y].each_index do |x|
                if @area_combat[y][x] == VOID
                    Gosu.draw_rect(x*WIDTH_TILE, y*HEIGHT_TILE, WIDTH_TILE, HEIGHT_TILE,Gosu::Color::BLACK)
                elsif @area_combat[y][x] == PLAYER
                    @player.draw(x*WIDTH_TILE_PLAYER, y*HEIGHT_TILE_PLAYER)
                end
            end
        end
    end
end
Main.new.show