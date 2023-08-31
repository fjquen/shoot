module Beam
    BEAM = "|"
    def move_beam(player)
        pos_row_player = @area_combat.flatten.index(player)
        pos_col_player = @area_combat.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @y = row_player
        @y -= 1
    end
end