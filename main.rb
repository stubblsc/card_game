require_relative 'card_game'
require_relative 'playable'

include Playable

game = CardGame.new

5.times do
  game.add_player(game.get_player_name)
end

while true
  game.start_game
  game.deal_cards
  game.game_results.each do |result|
    puts result
  end

  break unless game.play_again?
end
