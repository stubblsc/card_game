require_relative 'player'
require_relative 'dealer'

class CardGame
  def initialize
    @dealer = Dealer.new
    @players = [@dealer]
  end

  def start_game
    @deck = Deck.new
    @deck.shuffle!
    @players.map(&:reset)
  end

  def deal_cards
    2.times do
      @players.each do |player|
        player.take_card(@deck)
      end
    end
  end

  def add_player
    puts "Enter player name: "
    name = gets.chomp
    @players << Player.new(name)
  end

  def print_game_result
    @players.each do |player|
      if player.is_a? Dealer
        puts player.result(players_only)
      else
        puts player.result(@dealer)
      end
    end
  end

  private

  def players_only
    @players - [@dealer]
  end
end
