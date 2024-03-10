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
        super SCREEN_WIDTH,SCREEN_HEIGHT,true,100
        self.caption = "Shoot"
        @current_level = 0
        @arr=[]
        File.foreach("maps/map_#@current_level.txt") { |line| 
            @arr<<line.split("")
        }
        
        @player = Gosu::Image.new("media/playerShip1_blue.png")
        @ennemy = Gosu::Image.new("media/enemyRed1.png")
        @x=@y=@yBeam=0
        @font = Gosu::Font.new(20)
        @tab_move_ennemy = ["r","l","s","b"]
        @tab_move_player = ["r","l"]
        @bool = false
        @background_image = Gosu::Image.new("media/space.png")
        @count_life = 3
        @pos_player = @arr.flatten.index(PLAYER) / @arr.first.size
        @end = false
        @positionPlayer = @arr.flatten.select { |n| n == PLAYER }.length
        @yBeamTest = @pos_player -1
        @arrShort = []
    end
    
    ##
    # The function "update" checks the number of enemies and player lives, and then calls different
    # functions based on the conditions.
    def update
        @number_ennemy = @arr.flatten.select { |n| n == ENNEMY }.length
        @number_player = @arr.flatten.select { |n| n == PLAYER }.length
        
        if @count_life > 0 && !@end
            move_again_player()
        end
        if @number_ennemy == 0 && @count_life > 0
            next_level()
        end
        
        move_ennemy()
        # This block of code is iterating over each element in the `@arr` array, which represents the
        # game map. For each element, it is checking if the value is equal to `BEAM_TEST` and the
        # current row `y` is not the first row (y != 0). If these conditions are met, it adds a hash
        # containing the x and y coordinates to the `@arrShort` array.
        gun_beam()
        
        if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
            move_player(@tab_move_player[1])
        end
        
        if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
            move_player(@tab_move_player[0])
        end
    end

    # The `button_down` method is a callback method in the `Gosu::Window` class that is called
    # whenever a button is pressed. In this case, it is used to handle different button presses and
    # perform corresponding actions.
    def button_down(id)
        case id
            when Gosu::KB_ESCAPE
                close
            when Gosu::KB_R, Gosu::GP_BUTTON_2
              if @count_life == 0
                File.foreach("maps/map_#@current_level.txt") { |line| 
                    @arr<<line.split("")
                }
                @count_life = 3
              end
            when Gosu::KB_A,Gosu::GP_BUTTON_1
                # This block of code is checking if the index of the `PLAYER` character is found in
                # the flattened `@arr` array and if the size of the first row of `@arr` is not nil. If
                # these conditions are met, it calculates the column position of the player
                # (`col_player`) by taking the modulo of the index of the player in the flattened
                # array with the size of the first row.
                if !@arr.flatten.index(PLAYER).nil? && !@arr.first.size.nil?
                    col_player = @arr.flatten.index(PLAYER) % @arr.first.size
                    @arr[@yBeamTest][col_player] = BEAM_TEST
                    @positionPlayer = @arr.length - 1
                    @arr[@positionPlayer][col_player] = PLAYER
                end

                
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
       if @end
         draw_game_end()
       end
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
        else
            @end = true
        end
    end
end
Main.new.show