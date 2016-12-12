require './deck'
require './player'
require './scan'

simon = Player.new("Simon")
comp = Player.new("Computer")


def play(player, comp)
  deck = Deck.new
  discard = Deck.new
  deck.make_deck
  deck.shuffle(8)
  deck.deal(player, comp, 7)
  discard.add_card(deck.cards.shift)

  your_turn = true

  while player.cards_left != 0 && comp.cards_left != 0
    if your_turn
      turn(player, discard, deck, comp)
      your_turn = false
    elsif !your_turn
      comp_turn(comp, discard, deck, player)
      your_turn = true
    end
    puts "\n\nYou have #{player.cards_left} cards remaining"
    puts "The opponent has #{comp.cards_left} cards remaining\n\n\n"
    $stdout.flush
  end

  if player.cards_left == 0
    puts "You win!"
  elsif comp.cards_left
    puts "You lose!"
  end

end

def turn(player, discard, deck, comp)
  top = discard.cards[0]
  puts "The top card is the #{top.rank} of #{top.suit}"
  $stdout.flush

  available = check_cards(player, top)
  while !available
    puts "You cannot play a card. Draw a card"
    player.add_card(deck.cards.shift)
    available = check_cards(player, top)
    if deck.cards_left == 0
      remake_deck(deck, player, comp)
    end
  end

  show_hand(player)



  while available
    puts "Which card would you like to play?"
    $stdout.flush
    i = scan.to_i
    card = player.hand[i]
    if card.rank == 8
      puts "What suit would you like?"
      $stdout.flush
      suit = scan.to_s

      suit.delete!("\n")
      suits = ["Hearts", "Clubs", "Spades", "Diamonds"]
      while !suits.include?(suit)
        puts "Please choose a suit"
        puts suits
        suit = scan.to_s
        suit.delete!("\n")
      end

      player.remove_card(card)
      card.suit = suit
      discard.add_card(card)
      discard.remove_card(top)
      available = false
    elsif card.rank == top.rank || card.suit == top.suit
      discard.add_card(card)
      player.remove_card(card)
      discard.remove_card(top)
      available = false
    else
      puts "Choose a card that has the same rank or suit as the top card"
      $stdout.flush
    end
  end

  puts "The top card is now the #{discard.cards[0].rank} of #{discard.cards[0].suit}"
end

def comp_turn(comp, discard, deck, player)
  top = discard.cards[0]

  available = check_cards(comp, top)

  count = 0
  while !available
    comp.add_card(deck. cards.shift)
    available = check_cards(comp, top)
    if deck.cards_left == 0
      remake_deck(deck, player, comp)
    end

    count += 1
  end

  if count > 0
    puts "The compter had to draw #{count} times"
  end

  comp.deck.cards.each do |card|
    if available
      if card.rank == top.rank || card.suit == top.suit
        discard.add_card(card)
        comp.remove_card(card)
        discard.remove_card(top)
        available = false
      elsif card.rank == 8
        comp.remove_card(card)

        suits = ["Hearts", "Clubs", "Spades", "Dimaonds"]
        suit = rand(4)
        card.suit = suits[suit]

        discard.add_card(card)
        discard.remove_card(top)
        available = false
      end
    end
  end

  puts "The computer played the #{discard.cards[0].rank} of #{discard.cards[0].suit}"
  $stdout.flush
end

def show_hand(player)
  count = 0

  puts "Your hand is:"
  player.hand.each do |card|
    puts "#{count}. The #{card.rank} of #{card.suit}"
    $stdout.flush
    count += 1
  end
end

def check_cards(player, top)
  player.hand.each do |card|
    if top.rank == card.rank || top.suit == card.suit
      return true
    elsif card.rank == 8
      return true
    end
  end

  return false
end

def remake_deck(deck, p1, p2)
  deck.make_deck
  deck.shuffle(8)

  p1.hand.each do |card|
    deck.remove_card(card)
  end

  p2.hand.each do |card|
    deck.remove_card(card)
  end
end


play(simon, comp)
