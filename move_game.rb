require './constant.rb'
module Move_game
    include Constant

    def move_right_player()
        player = @arr.flatten.select { |n| n == "§" }.length
        if player>0
            pos_row_player = @arr.flatten.index(PLAYER)
            pos_col_player = @arr.first.size
            row_player = pos_row_player / pos_col_player
            col_player = pos_row_player % pos_col_player
            @x = col_player
            limit_x = pos_col_player - 1
            if @x < limit_x
                @x += 1
            else
                @x = limit_x
            end
            return if @arr[row_player][@x] < VOID
            @arr[row_player][col_player],@arr[row_player][@x] = @arr[row_player][@x],@arr[row_player][col_player]
        end
    end

    def move_left_player()
        player = @arr.flatten.select { |n| n == "§" }.length
        if player>0
            pos_row_player = @arr.flatten.index(PLAYER)
            pos_col_player = @arr.first.size
            row_player = pos_row_player / pos_col_player
            col_player = pos_row_player % pos_col_player
            @x = col_player
            limit_x = 0
            if @x > limit_x
                @x -= 1
            else
                @x = limit_x
            end
            return if @arr[row_player][@x] < VOID
            @arr[row_player][col_player],@arr[row_player][@x] = @arr[row_player][@x],@arr[row_player][col_player]
        end
    end

    def move_ennemy
        if @number_ennemy>0
            move_ennemy = []
            @arr.each_index do |y|
                @arr[y].each_index do |x|
                    if @arr[y][x] == ENNEMY
                        move_ennemy<<{"y"=>y,"x"=>x}
                    end
                end
            end
            random_legion = move_ennemy.sample
            case @tab_move_ennemy.sample
                when "r"
                    if random_legion["x"]<@arr.length
                        @arr[random_legion["y"]][random_legion["x"]] = VOID
                        random_legion["x"]+=1
                        if @arr[random_legion["y"]][random_legion["x"]] == ENNEMY
                            random_legion["x"]-=1
                            @arr[random_legion["y"]][random_legion["x"]] = ENNEMY
                        else
                            @arr[random_legion["y"]][random_legion["x"]] = ENNEMY
                        end
                    end
                when "l"
                    if random_legion["x"]<@arr.length || random_legion["x"]>0
                        @arr[random_legion["y"]][random_legion["x"]] = VOID
                        random_legion["x"]-=1
                        if @arr[random_legion["y"]][random_legion["x"]] == ENNEMY
                            random_legion["x"]+=1
                            @arr[random_legion["y"]][random_legion["x"]] = ENNEMY
                        else
                            @arr[random_legion["y"]][random_legion["x"]] = ENNEMY
                        end
                    end 
                when "s"
                    @arr[random_legion["y"]][random_legion["x"]] = VOID
                    random_legion["x"]=random_legion["x"]
                    @arr[random_legion["y"]][random_legion["x"]] = ENNEMY
                when "b"
                    sum_y_ennemy = random_legion["y"] + 1
                    num_test = @arr.length - sum_y_ennemy
                    for n in 1..num_test
                        random_legion["y"] += 1
                        if @arr[random_legion["y"]][random_legion["x"]] == ENNEMY
                            @arr[random_legion["y"]][random_legion["x"]] = ENNEMY
                        else
                            @arr[random_legion["y"]][random_legion["x"]] = BEAM
                        end
                    end
                end
            end
    end

    def move_again_player
        if @number_player == 0
            @count_life -= 1
            arr = @area_combat.last()
            num_random = @area_combat.last().length
            arr[rand(num_random)] = PLAYER
        end
    end
end