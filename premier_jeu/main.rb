require 'gosu'
require './player.rb'
require './legion.rb'
require './lose.rb'
require './ending.rb'

class Main < Gosu::Window
    
    def initialize
        super 640,480
        self.caption = "premier jeu"
        @player = Player.new
        @player.warp(32,400)
        @bool =true
        @legion = Legion.new
        @legion.create_legion_of_ennemy
        @background_image = Gosu::Image.new(@legion.level_background[@legion.chgt_decor]["source"], :tileable => true)
        @lose = Lose.new
        @ending = Ending.new
        @lose_bool = false
        @ending_bool = false
    end
    
    def update
        if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
            @player.move_right
        end
        if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
            @player.move_left
        end
        if Gosu.button_down? Gosu::KB_SPACE
           @player.fire
           @player.visibleBeam(true)
        else
           @player.returnFire
           @player.visibleBeam(false)
        end
        @legion.tabLegion.each_with_index do | element, x |
            @legion.tabLegion.each_with_index do | element, y |
                if Gosu.distance(@legion.tabLegion[x]['x'],@legion.tabLegion[y]['y'], @player.x_fire, @player.y_fire) < 25
                    @legion.tabLegion[x]['existence']= false
                elsif Gosu.distance(@legion.tabLegion[x]['x'],@legion.tabLegion[y]['y'], @player.x, @player.y) < 25
                    @lose_bool = true
                end
            end
        end
         @legion.move_forward
         @legion.back_again_legion
        if @legion.chgt_decor >= @legion.level_background.length
            @ending_bool = true
        else
            @background_image = Gosu::Image.new(@legion.level_background[@legion.chgt_decor]["source"], :tileable => true)
        end
    end
   
    def draw
        if @lose_bool == true
            @lose.draw
        end
        if @legion.chgt_decor >= @legion.level_background.length
            @ending.draw
        else
            @background_image.draw(@legion.level_background[@legion.chgt_decor]["x"],@legion.level_background[@legion.chgt_decor]["y"],0)
        end
        if @lose_bool == false && @ending_bool == false
          @player.draw
        end
        
        @legion.tabLegion.length.times { |i|
            if @legion.tabLegion[i]['existence'] == true && @lose_bool == false && @ending_bool == false
                @legion.draw(@legion.tabLegion[i]['x'],@legion.tabLegion[i]['y'])
            end
        }
    end
end
Main.new.show