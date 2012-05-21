require_relative 'player'
require_relative 'game_turn'
require_relative 'treasure_trove'
require 'csv'
module StudioGame

class Game
  
  attr_reader :title
  
  def initialize title
    @title = title
    @players = []
  end
  #create a method that adds a player to the player array
  def add_player a_player
    @players.push (a_player)
  end
  #loop that prints the players and plays the game
  def play rounds
    puts "There are #{@players.size} players in #{@title}:"
  #block that prints a player
    @players.each do |player|
      puts player
    end

  treasures = TreasureTrove::TREASURES
  puts "\nThere are #{treasures.size} treasures to be found:"
  treasures.each do |treasure|
    puts "A #{treasure.name} is worth #{treasure.points} points"
  end
  #block that allows multiple games to be played
  1.upto(rounds) do |round|
     puts "\nRound #{round}:"
    @players.each do |player|
       GameTurn.take_turn(player)
    end
  end
  end
  
  def total_points
    @players.reduce(0) { |sum, player| sum + player.points }
  end
  
  def print_name_and_health(p)
    puts "#{p.name} (#{p.health})"
  end
  
  def print_stats
    
    puts "\n#{@title} Statistics:"

    strong_players, wimpy_players = @players.partition { |player| player.strong? }

    puts "#{strong_players.size} strong players:"
    strong_players.each do |player|
      print_name_and_health(player)
    end    

    puts "#{wimpy_players.size} wimpy players:"
    wimpy_players.each do |player|
      print_name_and_health(player)
    end 
       
    puts "\n#{@title} High Scores:"
    @players.sort.each do |player|
      puts "#{player.format_name} #{player.score}"
    end
    
    @players.sort.each do |player|
      puts  "\n#{player.name}'s point totals:"
      player.each_found_treasure do |treasure|
        puts "#{treasure.points} total #{treasure.name} points"
      end
      
       puts "#{player.points} grand total points"
   
    end
    
    puts "\n#{total_points} total points from treasures found"
 
  end

  def load_players (filename="players.csv")
    CSV.foreach(filename) do |line|
      player = Player.new(line[0], line[1].to_i)
      add_player(player)
    end
  end

  def save_high_scores (filename="high_scores.txt")
    File.open(filename,"w") do |file|
      file.puts "#{@title} High Scores:"
      @players.sort.each do |player|
        file.puts "#{player.format_name}#{player.score}"
      end
    end
  end
  
end

end