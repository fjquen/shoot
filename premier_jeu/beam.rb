module Beam
    BEAM = "|"
    def move_beam(player,void)
        pos_row_player = @area_combat.flatten.index(player)
        pos_col_player = @area_combat.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @y = row_player
        @y -= 1
        @area_combat.each_index do |y|
            @area_combat[y].each_index do |x|
                if @area_combat[row_player][@y] == void
                    if col_player==x && y==@y
                        @area_combat[@y][x] = BEAM
                    end
                    
                end
            end
        end
    end
end