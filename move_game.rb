require './constant.rb'
module Move_game
    include Constant

    def move_right_player()
        player = @area_combat.flatten.select { |n| n == "§" }.length
        if player>0
            pos_row_player = @area_combat.flatten.index(PLAYER)
            pos_col_player = @area_combat.first.size
            row_player = pos_row_player / pos_col_player
            col_player = pos_row_player % pos_col_player
            @x = col_player
            limit_x = pos_col_player - 1
            if @x < limit_x
                @x += 1
            else
                @x = limit_x
            end
            return if @area_combat[row_player][@x] < VOID
            @area_combat[row_player][col_player],@area_combat[row_player][@x] = @area_combat[row_player][@x],@area_combat[row_player][col_player]
        end
    end

    def move_left_player()
        player = @area_combat.flatten.select { |n| n == "§" }.length
        if player>0
            pos_row_player = @area_combat.flatten.index(PLAYER)
            pos_col_player = @area_combat.first.size
            row_player = pos_row_player / pos_col_player
            col_player = pos_row_player % pos_col_player
            @x = col_player
            limit_x = 0
            if @x > limit_x
                @x -= 1
            else
                @x = limit_x
            end
            return if @area_combat[row_player][@x] < VOID
            @area_combat[row_player][col_player],@area_combat[row_player][@x] = @area_combat[row_player][@x],@area_combat[row_player][col_player]
        end
    end
end