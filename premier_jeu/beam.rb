module Beam
    BEAM = "|"
    POSITION_BEAM = 24
    WIDTH_TILE_BEAM = 15
    HEIGHT_TILE_BEAM = 55
    def move_beam(player,void)
        pos_row_player = @area_combat.flatten.index(player)
        pos_col_player = @area_combat.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @y = row_player
        @y -= 1
        @area_combat.each_index do |y|
            @area_combat[y].each_index do |x|
                if @area_combat[@y][col_player] == void
                    if col_player==x && y==@y
                        @area_combat[@y][x] = BEAM
                        i = 0
                        loop do
                        break if i == y
                        i = i + 1
                        puts y
                        @area_combat[i][x] = BEAM
                        end
                    end
                end
            end
        end
    end
end