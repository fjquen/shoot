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

    def move_ennemy
        if @number_ennemy>0
            move_ennemy = []
            @area_combat.each_index do |y|
                @area_combat[y].each_index do |x|
                    if @area_combat[y][x] == ENNEMY
                        move_ennemy<<{"y"=>y,"x"=>x}
                    end
                end
            end
            random_legion = move_ennemy.sample
            case @tab_move_ennemy.sample
                when "r"
                    if random_legion["x"]<@area_combat.length
                        @area_combat[random_legion["y"]][random_legion["x"]] = VOID
                        random_legion["x"]+=1
                        if @area_combat[random_legion["y"]][random_legion["x"]] == ENNEMY
                            random_legion["x"]-=1
                            @area_combat[random_legion["y"]][random_legion["x"]] = ENNEMY
                        else
                            @area_combat[random_legion["y"]][random_legion["x"]] = ENNEMY
                        end
                    end
                when "l"
                    if random_legion["x"]<@area_combat.length || random_legion["x"]>0
                        @area_combat[random_legion["y"]][random_legion["x"]] = VOID
                        random_legion["x"]-=1
                        if @area_combat[random_legion["y"]][random_legion["x"]] == ENNEMY
                            random_legion["x"]+=1
                            @area_combat[random_legion["y"]][random_legion["x"]] = ENNEMY
                        else
                            @area_combat[random_legion["y"]][random_legion["x"]] = ENNEMY
                        end
                    end 
                when "s"
                    @area_combat[random_legion["y"]][random_legion["x"]] = VOID
                    random_legion["x"]=random_legion["x"]
                    @area_combat[random_legion["y"]][random_legion["x"]] = ENNEMY
                when "b"
                    sum_y_ennemy = random_legion["y"] + 1
                    num_test = @area_combat.length - sum_y_ennemy
                    for n in 1..num_test
                        random_legion["y"] += 1
                        if @area_combat[random_legion["y"]][random_legion["x"]] == ENNEMY
                            @area_combat[random_legion["y"]][random_legion["x"]] = ENNEMY
                        else
                            @area_combat[random_legion["y"]][random_legion["x"]] = BEAM
                        end
                    end
                end
            end
    end

    def move_again_player
        if @number_player == 0
            arr = @area_combat.last()
            num_random = @area_combat.last().length
            arr[rand(num_random)] = PLAYER
        end
    end
end