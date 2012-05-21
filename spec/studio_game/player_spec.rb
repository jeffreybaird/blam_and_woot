require 'studio_game/player'
require 'studio_game/treasure_trove.rb'

module StudioGame

describe Player do
  context "player has health over 100" do
    before do
      @player = Player.new("jeff", 150)
    end
    it "is strong" do
      @player.should be_strong
    end
    it "computes a score as the sum of its health and points" do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))

      @player.score.should == 250
    end  
    it "has a string representation" do  
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))

      @player.to_s.should == "I'm Jeff with health = 150, points = 100, and score = 250."
    end
  end
  context "player has a health of less than 100" do
    before do
    @player = Player.new("clare", 90)
    end
    it "is wimpy" do
      @player.should_not be_strong
    end
  end
  context "in a collection of players" do
    before do
      @player1 = Player.new("moe", 100)
      @player2 = Player.new("larry", 200)
      @player3 = Player.new("curly", 300)

      @players = [@player3, @player2, @player1]
      @players.sort
    end

    it "is sorted by decreasing score" do
      @players.should == [@player1, @player2, @player3]
    end
    it "computes points as the sum of all treasure points" do
      @player1.points.should == 0

      @player1.found_treasure(Treasure.new(:hammer, 50))

      @player1.points.should == 50

      @player1.found_treasure(Treasure.new(:crowbar, 400))

      @player1.points.should == 450

      @player1.found_treasure(Treasure.new(:hammer, 50))

      @player1.points.should == 500
    end
    it "yields each found treasure and its total points" do
      @player1.found_treasure(Treasure.new(:skillet, 100))
      @player1.found_treasure(Treasure.new(:skillet, 100))
      @player1.found_treasure(Treasure.new(:hammer, 50))
      @player1.found_treasure(Treasure.new(:bottle, 5))
      @player1.found_treasure(Treasure.new(:bottle, 5))
      @player1.found_treasure(Treasure.new(:bottle, 5))
      @player1.found_treasure(Treasure.new(:bottle, 5))
      @player1.found_treasure(Treasure.new(:bottle, 5))

      yielded = []
      @player1.each_found_treasure do |treasure|
        yielded << treasure
      end

      yielded.should == [
        Treasure.new(:skillet, 200), 
        Treasure.new(:hammer, 50), 
        Treasure.new(:bottle, 25)
     ]
    end
    it "can be created from a CSV string" do  
      @player = Player.create_player_from_csv("larry,150")

      @player.name.should == "Larry"
      @player.health.should == 150
    end
  end
  
end

end