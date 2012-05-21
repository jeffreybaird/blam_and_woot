require_relative 'die'
require_relative 'player'
require_relative 'treasure_trove'

module StudioGame
  
module GameTurn
 def self.take_turn (player)
   die = Die.new
   number = die.roll
   case number
     when  1..2
       player.blam
     when  3..4
      puts "#{player.name} was skipped"
     else 
      player.woot
   end
    treasure = TreasureTrove.random
   player.found_treasure(treasure)
 end
end
end
if __FILE__ == $0
  die = Die.new
  player = Player.new("curly", 125)
  GameTurn.take_turn(player)
  GameTurn.take_turn(player)
  GameTurn.take_turn(player)
  GameTurn.take_turn(player)
  GameTurn.take_turn(player)
  GameTurn.take_turn(player)
  GameTurn.take_turn(player)
end