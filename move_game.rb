require './constant.rb'

module Move_game
    include Constant

    
    
    ##
    # Cette fonction Ruby `move_player` est conçue pour déplacer un joueur représenté par le symbole
    # "§" dans un tableau 2D en fonction de la direction d'entrée ("r" pour droite, "l" pour gauche)
    # tout en considérant les limites du tableau.
    # 
    # Args:
    #   move: La méthode `move_player` prend un paramètre `move`, qui représente la direction dans
    # laquelle le joueur doit se déplacer. Les valeurs possibles pour `move` sont "r" pour droite et
    # "l" pour gauche.
    # 
    # Returns:
    #   La méthode `move_player` renvoie `nil` si la condition `@arr[row_player][@x] < VOID` n'est pas
    # remplie.
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
                    @x += 1 if @x < limit_x
                    
                when "l"
                    limit_x = 0
                    @x -= 1 if @x > limit_x
            end
            return if @arr[row_player][@x] < VOID
                    @arr[row_player][col_player],@arr[row_player][@x] = @arr[row_player][@x],@arr[row_player][col_player]
        end
    end

    
    ##
    # La fonction `move_ennemy` dans Ruby déplace les personnages ennemis dans un tableau 2D basé sur
    # des directions aléatoires et met à jour leurs positions en conséquence.
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
    # Cette fonction Ruby diminue le nombre de points de vie du joueur et déplace le joueur de manière
    # aléatoire vers une nouvelle position s'il est à la position 0.
    def move_again_player
        if @number_player == 0
            @count_life -= 1
            arr = @arr.last()
            num_random = @arr.last().length
            arr[rand(num_random)] = PLAYER
        end
    end
end