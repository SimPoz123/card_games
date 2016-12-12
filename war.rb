require './deck'
require './player'

deck = Deck.new
simon = Player.new("Simon")
will = Player.new("Will")

deck.make_deck
deck.shuffle(8)
deck.deal(simon, will, 26)

def play(player1, player2)
  top = 0
  puts "\n\n\n#{player1.name} has the #{player1.card(top)} of #{player1.deck.cards[top].suit}"
  puts "#{player2.name} has the #{player2.card(top)} of #{player2.deck.cards[top].suit}\n"

  wars = 1
  top = 0
  if check_winner(player1, player2, top) == "War"


    while player1.card(top) == player2.card(top)
      wars += 2
      top += 2
    end
  #
  #
  #
  # else
  #   winner = (check_winner(player1, player2, top))[0]
  #   loser = (check_winner(player1, player2, top))[1]
  #   winner.add_card(loser.deck.cards.shift)
  #
  puts "HEY SINONS  SWOLOAEFOIAQAOLOOK A WAR gggsaagahhhhh"
  end

  winner = (check_winner(player1, player2, top))[0]
  loser = (check_winner(player1, player2, top))[1]

  wars.times do
    winner.add_card(loser.deck.cards.shift)
    winner.deck.shuffle
  end
  puts "#{winner.name} won"




  puts "#{player1.name} has #{player1.deck.cards.length} cards left"
  puts "#{player2.name} has #{player2.deck.cards.length} cards left"

  if !(cards_left(player1, player2))
    puts "\n\n\n\n#{winner.name} has won!!!!"
  end

end

def check_winner(player1, player2, top)
  if player1.card(top) > player2.card(top)
    return [player1, player2]
  elsif player1.card(top) < player2.card(top)
    return [player2, player1]
  elsif player1.card(top) == player2.card(top)
    return "War"
  end
end

def cards_left(player1, player2)
  if player1.deck.cards.length != 0 && player2.deck.cards.length != 0
    return true
  else
    return false
  end
end

while simon.deck.cards.length != 0 && will.deck.cards.length != 0
  play(simon, will)
end
