require './deck'

class Player

  attr_accessor :name, :deck

  def initialize(name)
    @name = name
    @deck = Deck.new()
  end

  def add_card(card)
    deck.cards.push(card)
  end

  def remove_card(card)
    deck.cards.delete(card)
  end

  def show_cards
    deck.cards.each do |card|
      puts "#{card.rank} of #{card.suit}"
      $stdout.flush
    end
  end

  def card(i)
    deck.cards[i].rank
  end

  def hand
    return deck.cards
  end

  def cards_left
    return deck.cards.length
  end

end
