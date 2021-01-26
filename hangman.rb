class Game
  attr_accessor :name 
 
   def initialize()
    
     @name = ""
     @guesses = []
     @secret_word = ""
     @progress_display = []
 
   end
   
   def get_name()
     puts "Please enter your name..."
     @name = gets.chomp
   end
 
   def intro()
 
     puts "Welcome to Hangman, #{@name}!"
     sleep(2)
     puts "Will you be..."
     sleep(1)
     puts "(1) Starting a new game..."
     sleep(1)
     puts "...or (2) continuing a saved game?"
 
     game_type = gets.chomp
 
     if game_type == "1"
       new_game()  
     else
       saved_game()
     end 
 
   end  
 
 
   #random word generator and state update
   def generate_word()
 
     word = File.readlines("dictionary.txt").sample.split('')
     word.pop(2)
     word.length() > 4 && word.length() < 13 ? @secret_word = word : generate_word()
 
   end  
 
 
   def update_progress()
     if !@guesses[0]
       @secret_word.map { |letter| @progress_display.push("-")}
     end  
     if @guesses[0] 
       @progress_display.map.with_index { |letter, index| 
         if @guesses[@guesses.length() - 1] == @secret_word[index]
           letter = @secret_word[index]
         end    
       } 
     end
     print @progress_display.join('')
     
   end  
 
   def make_guess()
     puts "Enter a letter to make a guess..."
     player_guess = gets.chomp
     @guesses.push(player_guess)
   end  
 
 
   def new_game()
 
     puts "Wonderful!  Choosing a random word now..."
     sleep(2)
     generate_word()
     puts "...done!"
     sleep(1)
     update_progress()
     puts ""
     make_guess()
     update_progress()
     
   end  
 
 
   def run_new_game()
     get_name()
     intro()
   end  
 
 end  
 
 newGame = Game.new
 newGame.run_new_game()
 