require 'gosu'

require './constant.rb'
require './move_game.rb'
require './beam.rb'
require './draw_game.rb'



class Main < Gosu::Window
    include Constant
    include Move_game
    include Beam
    include Draw_game

    
    # La méthode `initialize` dans Ruby est une méthode spéciale qui est automatiquement appelée
    # lorsqu'une nouvelle instance d'une classe est créée. Dans cet extrait de code spécifique :
    def initialize
        super SCREEN_WIDTH,SCREEN_HEIGHT,true,100
        self.caption = "Shoot"
        @current_level = 0
        @arr=[]
        File.foreach("maps/map_#@current_level.txt") { |line| 
            @arr<<line.split("")
        }
        
        @player = Gosu::Image.new("media/playerShip1_blue.png")
        @ennemy = Gosu::Image.new("media/enemyRed1.png")
        @x=@y=@yBeam=0
        @font = Gosu::Font.new(20)
        @tab_move_ennemy = ["r","l","s","b"]
        @tab_move_player = ["r","l"]
        @bool = false
        @background_image = Gosu::Image.new("media/space.png")
        @count_life = 3
        @pos_player = @arr.flatten.index(PLAYER) / @arr.first.size
        @end = false
        @positionPlayer = @arr.flatten.select { |n| n == PLAYER }.length
        @yBeamTest = @pos_player -1
        @arrShort = []
    end
    
    
    ##
    # La fonction « mise à jour » dans cet extrait de code Ruby gère diverses logiques de jeu telles
    # que la mise à jour du nombre de joueurs et d'ennemis, le déplacement des joueurs et des ennemis
    # et la vérification des conditions pour passer au niveau suivant.
    def update
        @number_ennemy = @arr.flatten.select { |n| n == ENNEMY }.length
        @number_player = @arr.flatten.select { |n| n == PLAYER }.length
        
        if @count_life > 0 && !@end
            move_again_player()
        end
        if @number_ennemy == 0 && @count_life > 0
            next_level()
        end
        
        move_ennemy()
        
        # La méthode `gun_beam()` dans l'extrait de code Ruby est responsable de la gestion de la
        # logique liée au tir d'un faisceau dans le jeu. Voici un aperçu de ce que fait la méthode
        # `gun_beam()` :
        gun_beam()
        
        # L'extrait de code que vous avez fourni vérifie les pressions sur les boutons permettant de
        # déplacer le personnage du joueur dans le jeu. Voici un aperçu de ce qu'il fait :
        if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
            move_player(@tab_move_player[1])
        end
        
        if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
            move_player(@tab_move_player[0])
        end
    end

    
    # La méthode `button_down` dans l'extrait de code Ruby fourni est une méthode de rappel qui gère
    # les événements d'entrée de l'utilisateur, en particulier les pressions sur une touche/un bouton.
    # Voici un aperçu de ce qu'il fait :
    def button_down(id)
        case id
            when Gosu::KB_ESCAPE
                close
            when Gosu::KB_R, Gosu::GP_BUTTON_2
              if @count_life == 0
                File.foreach("maps/map_#@current_level.txt") { |line| 
                    @arr<<line.split("")
                }
                @count_life = 3
              end
            when Gosu::KB_A,Gosu::GP_BUTTON_1
                
                # Ce bloc de code vérifie si le personnage du joueur existe dans la grille de jeu
                # représentée par `@arr`, et si la taille de la première ligne de la grille n'est pas
                # nulle. Si ces conditions sont remplies, il effectue les actions suivantes :
                if !@arr.flatten.index(PLAYER).nil? && !@arr.first.size.nil?
                    col_player = @arr.flatten.index(PLAYER) % @arr.first.size
                    @arr[@yBeamTest][col_player] = BEAM_TEST
                    @positionPlayer = @arr.length - 1
                    @arr[@positionPlayer][col_player] = PLAYER
                end

                
        end
    end
   
    
    ##
    # La fonction « draw » de Ruby est responsable du rendu de divers éléments d'un jeu, notamment la
    # zone de jeu, le texte, l'image d'arrière-plan et l'écran de jeu.
    def draw
       draw_area()
       draw_text()
       draw_game_over()
       @background_image.draw(0, 0, 0)
       if @end
         draw_game_end()
       end
    end

    
    # La méthode `next_level` dans l'extrait de code Ruby fourni est chargée de faire passer le jeu au
    # niveau suivant. Voici un aperçu de ce que fait cette méthode :
    def next_level
        @current_level += 1
        path = "maps/map_#@current_level.txt"
    
        if File.exist?(path)
            @arr.clear
            File.foreach(path) { |line| 
                @arr<<line.split("")
            }
            @count_life = 3
        else
            @end = true
        end
    end
end
Main.new.show