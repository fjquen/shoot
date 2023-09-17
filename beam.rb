require './constant.rb'
module Beam
    include Constant
    
    def move_beam()
        pos_row_player = @area_combat.flatten.index(PLAYER)
        pos_col_player = @area_combat.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @y = row_player
        @y -= 1
        @area_combat.each_index do |y|
            @area_combat[y].each_index do |x|
                if @area_combat[@y][col_player] == VOID
                    if col_player==x && y==@y
                        @area_combat[y][x] = BEAM
                            for y in 0..@area_combat.length
                                next if @area_combat[@y][col_player] == VOID
                                    y-= 1
                                    @area_combat[y][x] = BEAM
                                    player = @area_combat.length - 1
                                    @area_combat[player][col_player] = PLAYER
                            end
                    end    
                end
            end
        end
    end
end