class Player
  attr_reader :name
  attr_reader :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def take_card(deck)
    @cards << deck.draw_card!
  end

  def result(dealer)
    result_string = if score > dealer.score
                      'Win'
                    elsif score == dealer.score
                      'Push'
                    else
                      'Lose'
                    end
    "#{@name} (#{result_string}): #{@cards.map(&:to_s)} - #{score}"
  end

  def score
    @cards.map(&:score)
          .inject(:+)
  end

  def reset
    @cards = []
  end
end
