require_relative 'player'
require_relative 'deck'

class Dealer < Player
  def initialize
    super("Dealer")
  end

  def result(players)
    p players
    win_count = players.map(&:score).count{|player_score| player_score < score}
    "#{@name} (Beat #{win_count}): #{@cards.map(&:to_s)} - #{score}"
  end
end
