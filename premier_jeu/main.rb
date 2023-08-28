require 'gosu'


class Main < Gosu::Window
    
    def initialize
        super 640,480
        self.caption = "premier jeu"
        @area_combat = [["°","°","°","°","°","°","°","°","°",],
                        [" "," "," "," "," "," "," "," "," ",],
                        [" "," "," "," "," "," "," "," "," ",],
                        [" "," "," "," "," "," "," "," "," ",],
                        [" "," "," "," "," "," "," "," "," ",],
                        [" "," "," "," ","§"," "," "," "," ",]]
    end
    
    def update
        
    end
   
    def draw
        
    end
end
Main.new.show