require_relative 'treasure_trove'
require_relative 'playable'

module StudioGame

class Player
 
  include Playable
  attr_accessor :name, :health
    
    def initialize (name, health=100)
      @name   = name.capitalize
      @health = health
      @found_treasures = Hash.new(0)
    end
    
    def to_s
      "I'm #{@name} with health = #{@health}, points = #{self.points}, and score = #{score}."
    end
    
    def format_name
      name.ljust(20, '.')
    end
    
    def self.create_player_from_csv line
      name, health = line.split(',')
        if health == nil
          health = 100
        end
      @player = Player.new(name.chomp, health.to_i)
    end

    def score
     @health + self.points
    end
    
    def <=> (other)
      other.score <=> score
    end
    
    def found_treasure treasure
      @found_treasures[treasure.name] += treasure.points
      puts "#{@name} found a #{treasure.name} worth #{treasure.points} points."
      puts "#{@name}'s treasures: #{@found_treasures}"
    end
    
    def points
      @found_treasures.values.reduce(0,:+)
    end
    
    def each_found_treasure
      @found_treasures.each do |name, points|
        yield Treasure.new(name, points)
      end
    end  
      
end

end

if __FILE__ == $0
  player = Player.new("moe")
  puts player.name
  puts player.health
  player.woot
  puts player.health
  player.blam
  puts player.health
  pie = Treasure.new(:pie,50)
  shit = Treasure.new(:shit, 500)
  player.found_treasure(shit)
  player.found_treasure(pie)
  player.each_found_treasure {|treasure| puts "#{treasure.name} is yummy" }
end