require 'gosu'



class Player
    attr_accessor :x_fire, :y_fire,:y,:x
    def initialize
        @spacePlayer = Gosu::Image.new("media/player.png", :tileable => true)
        @fireBeam = Gosu::Image.new("media/Fire-icon.png", :tileable => true)
        @x=@y=@x_fire=@y_fire = 0.0
    end

    def warp(x, y)
        @x, @y = x, y
        @x_fire, @y_fire = x + 10, y+10
    end

    def move_right 
        if @x < 570
            @x += 7
            @x_fire += 7
        else
            return @x
        end
    end

    def move_left
        if @x > 10
            @x -= 7
            @x_fire -= 7 
        else
            return @x
        end
    end

    def fire
        @y_fire -= 70
    end

    def returnFire
        return @y_fire = @y
    end
    
    def visibleBeam(bool)
        @bool = bool
    end

    def draw
        @spacePlayer.draw(@x,@y,0)

        if @bool
            @fireBeam.draw(@x_fire,@y_fire,0)
        end
    end
end