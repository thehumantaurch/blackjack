class View

  def start_game
    puts
    puts "Welcome to Blackjack!"
  end

  def hit_or_stand
    puts
    puts "Press 'h' to hit or 's' to stand"
    gets.chomp
  end

  def show_final_hand(player)
    player.hand.each do |card|
      puts "\t#{card.number} of #{card.suit}"
    end
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


end