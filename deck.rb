require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = build_deck
  end

  def shuffle!
    @cards.shuffle!
  end

  def draw_card!
    raise EmptyDeckError if @cards.size == 0

    @cards.pop
  end

  private

  def build_deck
    Card::SUITS.product(Card::VALUES).map do |card|
      Card.new(*card)
    end
  end
end

class EmptyDeckError < StandardError; end
