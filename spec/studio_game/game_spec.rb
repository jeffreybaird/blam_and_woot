require 'studio_game/player'
require 'studio_game/game'

module StudioGame

describe Game do 
  context "player with a health of 150" do
  before do
    @health = 150
    @player = Player.new("jeff", @health)
  end
  it "has a capitalized name" do
  @player.name.should == "Jeff"
  end
  it "has an initial health" do
  @health.should_not == nil
  end
  it "has a string representation" do
  @player.should_not == ""
  end
  it "computes a score as the sum of its health and length of name" do
  @player.score.should == (150)
  end
  it "increases health by 15 when w00ted" do
  @player.woot
  @player.health.should == (150 + 15)
  end
  it "decreases health by 10 when blammed" do
   @player.blam
   @player.health.should == (150 - 10)
  end
  it "assigns a treasure for points during a player's turn" do     
    game = Game.new("Knuckleheads")
    player = Player.new("moe")

    game.add_player(player)

    game.play(1)

    player.points.should_not be_zero
  end
  it "computes total points as the sum of all player points" do
    game = Game.new("Knuckleheads")

    player1 = Player.new("moe")
    player2 = Player.new("larry")

    game.add_player(player1)
    game.add_player(player2)

    player1.found_treasure(Treasure.new(:hammer, 50))
    player1.found_treasure(Treasure.new(:hammer, 50))
    player2.found_treasure(Treasure.new(:crowbar, 400))

    game.total_points.should == 500
  end
end
  context "Testing for randomness" do
    before do
       @game = Game.new("Knuckleheads")

       @initial_health = 100
       @player = Player.new("moe", @initial_health)

       @game.add_player(@player)
     end
     it "w00ts when there is a high roll" do
       Die.any_instance.stub(:roll).and_return(5)
       @game.play(2)
       @player.health.should == @initial_health + (15 * 2)
     end
     it "blams when there is a low roll" do
       Die.any_instance.stub(:roll).and_return(1)
        @game.play(2)
        @player.health.should == @initial_health - (10*2)
     end
     it "should skip when it is a medium roll" do
       Die.any_instance.stub(:roll).and_return(3)
        @game.play(2)
        @player.health.should == @initial_health
     end
  end
end
end
