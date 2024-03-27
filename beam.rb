require './constant.rb'
module Beam
    include Constant
    
    
    ##
    # La fonction `move_beam` de Ruby est conçue pour déplacer un faisceau dans une grille de jeu en
    # fonction de la position du joueur, mettant à jour la grille en conséquence.
    def move_beam()
        if @positionPlayer>0
            pos_row_player = @arr.flatten.index(PLAYER)
            pos_col_player = @arr.first.size
            row_player = pos_row_player / pos_col_player
            col_player = pos_row_player % pos_col_player
            @y = row_player
            @y -= 1
            @arr.each_index do |y|
                @arr[y].each_index do |x|
                    if @arr[@y][col_player] == VOID
                        if col_player==x && y==@y
                            @arr[y][x] = BEAM
                            for y in 0..@arr.length
                                next if @arr[@y][col_player] == VOID
                                    y-= 1
                                    @arr[y][x] = BEAM
                                    player = @arr.length - 1
                                    @arr[player][col_player] = PLAYER
                            end
                        end
                    elsif @arr[@y][col_player] == ENNEMY
                        if col_player==x && y==@y
                            @arr[y][x] = BEAM
                            for y in 0..@arr.length
                                next if @arr[@y][col_player] == ENNEMY
                                    y-= 1
                                    @arr[y][x] = BEAM
                                    player = @arr.length - 1
                                    @arr[player][col_player] = PLAYER
                            end
                        end
                    end
                end
            end
        end
    end


    ##
    # La fonction `gun_beam` parcourt un tableau 2D, déplaçant un faisceau vers le haut d'une position
    # si certaines conditions sont remplies.
    def gun_beam()
        @arr.each_index do |y|
            @arr[y].each_index do |x|
                if @arr[y][x] == BEAM_TEST && y != 0
                    @arrShort<<{"x"=>x,"y"=>y}    
                end
                @arrShort.each_index do |index|
                    if !@arr.flatten.index(PLAYER).nil? && !@arr.first.size.nil?
                        yBeam = @arrShort[index]["y"]
                        if @arr[yBeam][@arrShort[index]["x"]] < VOID
                            yBeam-=1
                            @arr[yBeam][@arrShort[index]["x"]] = BEAM_TEST
                            yBeam+=1
                            @arr[yBeam][@arrShort[index]["x"]] = VOID
                        end
                        @arr[0][x] = VOID
                        @arrShort.clear
                    end
                end
            end
        end
    end
end