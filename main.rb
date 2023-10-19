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
        self.caption = "premier jeu"
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
    end
    
    def update
       @number_ennemy = @area_combat.flatten.select { |n| n == "°" }.length
       if @number_ennemy>0
        move_ennemy = []
        @area_combat.each_index do |y|
            @area_combat[y].each_index do |x|
                if @area_combat[y][x] == "°"
                    move_ennemy<<{"y"=>y,"x"=>x}
                end
            end
        end
        random_legion = move_ennemy.sample
        case @tab_move_ennemy.sample
            when "r"
                if random_legion["x"]<@area_combat.length
                    @area_combat[random_legion["y"]][random_legion["x"]] = " "
                    random_legion["x"]+=1
                    if @area_combat[random_legion["y"]][random_legion["x"]] == "°"
                        random_legion["x"]-=1
                        @area_combat[random_legion["y"]][random_legion["x"]] = "°"
                    else
                        @area_combat[random_legion["y"]][random_legion["x"]] = "°"
                    end
                end
            when "l"
                if random_legion["x"]<@area_combat.length || random_legion["x"]>0
                    @area_combat[random_legion["y"]][random_legion["x"]] = " "
                    random_legion["x"]-=1
                    if @area_combat[random_legion["y"]][random_legion["x"]] == "°"
                        random_legion["x"]+=1
                        @area_combat[random_legion["y"]][random_legion["x"]] = "°"
                    else
                        @area_combat[random_legion["y"]][random_legion["x"]] = "°"
                    end
                end 
            when "s"
                @area_combat[random_legion["y"]][random_legion["x"]] = " "
                random_legion["x"]=random_legion["x"]
                @area_combat[random_legion["y"]][random_legion["x"]] = "°"
            when "b"
                sum_y_ennemy = random_legion["y"] + 1
                num_test = @area_combat.length - sum_y_ennemy
                for n in 1..num_test
                    random_legion["y"] += 1
                    if @area_combat[random_legion["y"]][random_legion["x"]] == "°"
                        @area_combat[random_legion["y"]][random_legion["x"]] = "°"
                    else
                        @area_combat[random_legion["y"]][random_legion["x"]] = "|"
                    end
                end
            end
        end
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
       draw_text_score()
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
                    @area_combat[y][x] = VOID
                end
            end 
        end
    end

    def draw_text_score
        @font.draw_text("Nombre d'ennemy à eliminey : #{ @number_ennemy}", 10, 10, 0, 1.0, 1.0, Gosu::Color::YELLOW)
    end
end
Main.new.show