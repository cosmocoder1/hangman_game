class Game
  
  def initialize()
    @name = get_name()
    @guesses = []
    @secret_word = secret_word()
    @progress = []
  end
  
  def get_name()
    puts "Please enter your name..."
    self.name = gets.chomp
  end

  def intro ()
    puts "Welcome to Hangman!"
    sleep(2)
    puts "Will you be..."
    sleep(1)
    puts "(1) Starting a new game..."
    sleep(1)
    puts "...or (2) continuing a saved game?"
    game_type = gets.chomp
    if game_type == 1
      new_game()  
    else
      saved_game()
    end  
  end  

  def new_game()


end  
