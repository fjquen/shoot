require './constant.rb'

module Move_game
    include Constant

    
    ##
    # The `move_player` function moves the player character in a 2D array based on the input move
    # direction.
    # 
    # Args:
    #   move: The parameter "move" is a string that represents the direction in which the player wants
    # to move. It can be either "r" for right or "l" for left.
    # 
    # Returns:
    #   The code is returning nothing if the condition `@arr[row_player][@x] < VOID` is true.
    # Otherwise, it is returning the updated `@arr` array.
    def move_player(move)
        player = @arr.flatten.select { |n| n == "§" }.length
        if player>0
            pos_row_player = @arr.flatten.index(PLAYER)
            pos_col_player = @arr.first.size
            row_player = pos_row_player / pos_col_player
            col_player = pos_row_player % pos_col_player
            @x = col_player
            case move
                when "r"
                    limit_x = @arr.last.size - 1
                    if @x < limit_x
                        @x += 1
                    else
                        @x = limit_x
                    end
                    
                when "l"
                    limit_x = 0
                    if @x > limit_x
                        @x -= 1
                    else
                        @x = limit_x
                    end
            end
            return if @arr[row_player][@x] < VOID
                    @arr[row_player][col_player],@arr[row_player][@x] = @arr[row_player][@x],@arr[row_player][col_player]
        end
    end

    ##
    # The `move_ennemy` function moves the enemy in a 2D array based on random directions and updates
    # the array accordingly.
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
                    num_test.times{
                        random_legion["y"] += 1
                        if @arr[random_legion["y"]][random_legion["x"]] == ENNEMY
                            @arr[random_legion["y"]][random_legion["x"]] = ENNEMY
                        else
                                @arr[random_legion["y"]][random_legion["x"]] = BEAM
                        end
                    }
                        
            end
        end
    end

    ##
    # The function `move_again_player` decreases the player's life count by 1 and randomly moves the
    # player to a new position on the game board.
    def move_again_player
        if @number_player == 0
            @count_life -= 1
            arr = @arr.last()
            num_random = @arr.last().length
            arr[rand(num_random)] = PLAYER
        end
    end
end