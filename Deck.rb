require './card'

class Deck

  attr_accessor :cards

  def initialize()
    @cards = []
  end

  def make_deck
    suits = ["Hearts", "Spades", "Clubs", "Diamonds"]

    suits.each do |suit|
      rank = 0

      13.times do
        rank += 1
        card = Card.new(suit, rank)
        cards.push(card)
      end

    end

    return cards
  end

  def shuffle(times)
    times.times do
      @cards = cards.shuffle
    end
    return @cards
  end


  def deal(player1, player2, i)
    i.times do
      player1.add_card(cards.shift)
      player2.add_card(cards.shift)
    end
  end

  def add_card(card)
    cards.push(card)
  end

  def remove_card(card)
    cards.delete(card)
  end

  def cards_left
    return cards.length
  end

end
