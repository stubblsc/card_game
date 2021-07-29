require_relative 'player'
require_relative 'dealer'

class CardGame
  attr_reader :players

  MAX_PLAYERS = 5

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

  def add_player(name)
    player = Player.new(name)
    @players << player
    player
  end

  def remove_player(player)
    @players.delete(player)
  end

  def game_results
    @players.map do |player|
      if player.is_a? Dealer
        player.result(players_only)
      else
        player.result(@dealer)
      end
    end
  end

  def player_count
    players_only.size
  end

  private

  def players_only
    @players - [@dealer]
  end
end
