require './constant.rb'
module Beam
    include Constant
    
    ##
    # The function `move_beam` moves a beam in a 2D array, updating the positions of the player and
    # enemies accordingly.
    def move_beam()
        player = @arr.flatten.select { |n| n == PLAYER }.length
        if player>0
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
end