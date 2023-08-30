module Move_game
    PLAYER = "§"
    ENNEMY = "°"
    VOID = " "
    WIDTH_TILE = 55
    HEIGHT_TILE = 55

    def move_right()
        pos_row_player = @area_combat.flatten.index(PLAYER)
        pos_col_player = @area_combat.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @x = col_player
        @x += 1
        # @area_combat.each_index do |y|
        #     @area_combat[y].each_index do |x|
        #         return if 
        #             @area_combat[y][@x],@area_combat[y][x] = @area_combat[y][x],@area_combat[y][@x]
        #     end
        # end
    end

    def move_left()
        pos_row_player = @area_combat.flatten.index(PLAYER)
        pos_col_player = @area_combat.first.size
        row_player = pos_row_player / pos_col_player
        col_player = pos_row_player % pos_col_player
        @x = col_player
        @x -= 1
        
        return if @x >= 0
            @area_combat[row_player][col_player],@area_combat[row_player][@x] = @area_combat[row_player][@x],@area_combat[row_player][col_player]
    end
end