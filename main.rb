require_relative 'card_game'

game = CardGame.new

5.times do
  game.add_player
end

while true
  game.start_game
  game.deal_cards
  game.print_game_result

  puts 'Play again? (Y/n) '
  val = gets.chomp
  break unless ['Y', 'y'].include? val
end
