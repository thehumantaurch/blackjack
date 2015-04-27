class Game
  SUITS = ["Clubs", "Spades", "Hearts", "Diamonds"]
  NUMBERS = ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K"]

  attr_reader :deck, :player, :dealer

  def initialize
    @deck = []
  end

  def create_deck
    SUITS.each do |suit|
      NUMBERS.each do |num|
        @deck << Card.new(suit, num)
      end
    end
  end

  def shuffle_deck
    @deck.shuffle!
  end

  def hit(hand)
    hand << @deck.pop
  end

end

class Card
  attr_reader :suit, :number
  attr_accessor :face_up

  def initialize(suit, number)
    @suit = suit
    @number = number
    @face_up = false
  end

  def flip
    @face_up = true
  end

end

class Player
  attr_accessor :hand, :total

  def initialize
    @hand = []
    @total = 0
  end

end