module StudioGame
  
Treasure = Struct.new(:name,:points)
module TreasureTrove
  TREASURES = [
    pie = Treasure.new(:pie,5),
    bottle = Treasure.new(:bottle,25),
    hammer = Treasure.new(:hammer,50),
    skillet = Treasure.new(:skillet,100),
    broomstick = Treasure.new(:broomstick,200),
    crowbar = Treasure.new(:crowbar, 400)
    ]
    
  def self.random
    TREASURES.sample
  end
end
end


