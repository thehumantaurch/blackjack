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

end