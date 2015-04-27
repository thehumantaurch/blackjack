require 'pry'
require_relative 'model'
require_relative 'view'

class Controller

  def initialize
    @game = Game.new
    @view = View.new
    @player = Player.new
    @dealer = Player.new
    @game.create_deck
    @game.shuffle_deck
  end

  def deal
    2.times do
      @player.hand << @game.deck.pop
      @dealer.hand << @game.deck.pop
    end
    @player.hand[-1].flip
    @dealer.hand[-1].flip
  end

  def check_hands
    puts "So far you have:"
    @player.hand.each do |card|
      if card.face_up == true
        puts "\t#{card.number} of #{card.suit}"
      end
    end
    puts "So far dealer has:"
    @dealer.hand.each do |card|
      if card.face_up == true
        puts "\t#{card.number} of #{card.suit}"
      end
    end
  end

  def show_dealer_hand
    puts
    puts "Dealer's final hand:"
    @dealer.hand.each do |card|
      puts "\t#{card.number} of #{card.suit}"
    end
  end

  def show_player_hand
    puts
    puts "Your final hand:"
    @player.hand.each do |card|
      puts "\t#{card.number} of #{card.suit}"
    end
  end

  def hand_total(player)
    hand_nums = []
    player.total = 0
    player.hand.each do |card|
      hand_nums << card.number
    end
    hand_nums.each do |val|
      if val.is_a?(Integer)
        player.total += val
      elsif val == "J" || val == "Q" || val == "K"
        player.total += 10
      else
        player.total += 0
      end
    end
    if hand_nums.include?("A")
      if player.total < 11
        player.total += 11
      else
        player.total += 1
      end
    end
    return player.total
  end

  def check_winner(final_player, final_dealer)
    if final_player == 21 && final_dealer == 21
      puts
      puts "Wow! You both got blackjack!"
    elsif final_player == 21
      puts
      puts "Congratulations, you win!"
    elsif final_dealer == 21
      puts
      puts "Sorry, you lose."
    elsif final_player > 21 && final_dealer < 21
      puts
      puts "Sorry, you lose."
    elsif final_player < 21 && final_dealer > 21
      puts
      puts "Congratulations, you win!"
    elsif final_player > 21 && final_dealer > 21
      puts
      puts "You're both bust. The dealer wins."
    elsif final_player < 21 && final_dealer < 21
      if final_player > final_dealer
        puts
        puts "Congratulations, you win!"
      elsif final_player == final_dealer
        puts
        puts "It's a tie!"
      else
        puts
        puts "Sorry, you lose."
      end
    end
  end


  def run
    @view.start_game
    deal
    check_hands
    input = @view.hit_or_stand
    until input == "s"
      @game.hit(@player.hand)
      hand_total(@dealer)
      if @dealer.total < 17
        @game.hit(@dealer.hand)
      end
      @player.hand[-1].flip
      @dealer.hand[-1].flip
      check_hands
      input = @view.hit_or_stand
    end
    final_player = hand_total(@player)
    final_dealer = hand_total(@dealer)
    show_player_hand
    show_dealer_hand
    check_winner(final_player, final_dealer)
  end

end

test = Controller.new
test.run