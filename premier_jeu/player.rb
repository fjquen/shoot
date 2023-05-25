require 'gosu'



class Player < Gosu::Window
    attr_accessor :x_fire, :y_fire,:y,:x, :boolSpatialship, :bool
    def initialize
        @spacePlayer = Gosu::Image.new("media/player.png", :tileable => true)
        @fireBeam = Gosu::Image.new("media/Fire-icon.png", :tileable => true)
        @x=@y=@x_fire=@y_fire = 0.0
        @bool = false
        @boolSpatialship = true
    end

    def warp(x, y)
        @x, @y = x, y
        @x_fire, @y_fire = x + 10, y+10
    end

    def move_right 
        if @x < 570 && @boolSpatialship == true
            @x += 7
            @x_fire += 7
        else
            return @x
        end
    end

    def move_left
        if @x > 10 && @boolSpatialship == true
            @x -= 7
            @x_fire -= 7 
        else
            return @x
        end
    end

    def fire
         if @boolSpatialship == true
            @y_fire -= 70
         end
    end

    def returnFire
        return @y_fire = @y
    end
    
    def visibleBeam(bool)
        @bool = bool
    end

    def draw
        if @boolSpatialship
            @spacePlayer.draw(@x,@y,0)
        end

        if @bool && @boolSpatialship
            @fireBeam.draw(@x_fire,@y_fire,0)
        end
    end
end