module Playable
  def play_again?
    puts 'Play again? (Y/n) '
    val = gets.chomp
    return true if ['Y', 'y'].include? val
  end

  def get_player_name
    puts "Enter player name: "
    gets.chomp
  end
end
