require 'gosu'



class Player
    attr_accessor :x_fire, :y_fire,:y,:x
    def initialize
        @spacePlayer = Gosu::Image.new("media/playerShip1_blue.png")
        @fireBeam = Gosu::Image.new("media/laserRed05.png")
        @x=@y=@x_fire=@y_fire = 0.0
    end

    def warp(x, y)
        @x, @y = x, y
        @x_fire, @y_fire = x + 28, y+28
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