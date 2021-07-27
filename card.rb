class Card
  SUITS = %i(Clubs Diamonds Hearts Spades)
  VALUES = %i(A 2 3 4 5 6 7 8 9 10 J Q K)
  SCORE_MAP = {
    A: 1,
    '2': 2,
    '3': 3,
    '4': 4,
    '5': 5,
    '6': 6,
    '7': 7,
    '8': 8,
    '9': 9,
    '10': 10,
    J: 11,
    Q: 12,
    K: 13
  }

  attr_reader :suit, :value

  def initialize(suit, value)
    raise CardSuitError unless SUITS.include? suit
    raise CardValueError unless VALUES.include? value

    @suit = suit
    @value = value
  end

  def score
    SCORE_MAP[@value]
  end

  def to_s
    "#{value} #{suit}"
  end
end

class CardSuitError < StandardError; end
class CardValueError < StandardError; end
