require 'gosu'
require './player.rb'
require './legion.rb'


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
                    @player.boolSpatialship = false
                end
            end
        end
         @legion.move_forward
         @legion.back_again_legion
         @background_image = Gosu::Image.new(@legion.level_background[@legion.chgt_decor]["source"], :tileable => true)
    end
   
    def draw
        @background_image.draw(140,15,0)
        @player.draw
        @legion.tabLegion.length.times { |i|
            if @legion.tabLegion[i]['existence'] == true
                @legion.draw(@legion.tabLegion[i]['x'],@legion.tabLegion[i]['y'],@legion.tabLegion[i]['color'])
            end
        }
    end
end
Main.new.show