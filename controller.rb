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

    puts "Your final hand:"
    @view.show_final_hand(@player)

    puts "Dealer's final hand:"
    @view.show_final_hand(@dealer)

    @view.check_winner(final_player, final_dealer)
  end

end

play = Controller.new
play.run