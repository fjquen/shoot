require 'gosu'
require './constant.rb'
require './move_game.rb'
require './beam.rb'
require './draw_game.rb'

class Main < Gosu::Window
    include Constant
    include Move_game
    include Beam
    include Draw_game

    # The `initialize` method is a special method in Ruby classes that is automatically called when a
    # new instance of the class is created. In this case, it is initializing the `Main` class, which
    # is a subclass of `Gosu::Window`.
    def initialize
        super 640,480
        self.caption = "Shoot"
        @current_level = 0
        @arr=[]
        File.foreach("maps/map_#@current_level.txt") { |line| 
            @arr<<line.split("")
        }
        @player = Gosu::Image.new("media/playerShip1_blue.png")
        @ennemy = Gosu::Image.new("media/enemyRed1.png")
        @x=@y=0
        @font = Gosu::Font.new(20)
        @tab_move_ennemy = ["r","l","s","b"]
        self.update_interval = 100
        @background_image = Gosu::Image.new("media/space.png", :tileable => true)
        @count_life = 3
    end
    
    ##
    # The function "update" checks the number of enemies and player lives, and then calls different
    # functions based on the conditions.
    def update
       @number_ennemy = @arr.flatten.select { |n| n == ENNEMY }.length
       @number_player = @arr.flatten.select { |n| n == PLAYER }.length
       if @count_life > 0
        move_again_player()
       end
       if @number_ennemy == 0 && @count_life > 0
            next_level()
       end
       move_ennemy()
    end

    # The `button_down` method is a callback method in the `Gosu::Window` class that is called
    # whenever a button is pressed. In this case, it is used to handle different button presses and
    # perform corresponding actions.
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
            when Gosu::KB_R
                File.foreach("maps/map_#@current_level.txt") { |line| 
                    @arr<<line.split("")
                }
                @count_life = 3
        end
    end
   
    ##
    # The function "draw" is responsible for drawing the game area, text, and game over screen using
    # the background image.
    def draw
       draw_area()
       draw_text()
       draw_game_over()
       @background_image.draw(0, 0, 0)
    end

    # The `next_level` method is responsible for advancing the game to the next level.
    def next_level
        @current_level += 1
        path = "maps/map_#@current_level.txt"
    
        if File.exist?(path)
            @arr.clear
            File.foreach(path) { |line| 
                @arr<<line.split("")
            }
            @count_life = 3
        end
    end
end
Main.new.show