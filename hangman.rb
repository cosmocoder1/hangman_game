class Game
  attr_accessor :name 
 
   def initialize()
    
     @name = ""
     @guesses = []
     @secret_word = secret_word()
     @progress = []
 
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
 
   def generate_word()
     
     word = File.readlines("dictionary.txt").sample.split('').pop().join('')
     
     puts word
 
   end  
 
   def new_game()
 
     puts "Wonderful!  Choosing a random word now..."
     sleep(2)
     generate_word()
     puts "...done!"
 
   end  
 
   def secret_word()
   end  
 
   def run_new_game()
     get_name()
     intro()
   end  
 
 end  
 
 newGame = Game.new
 newGame.run_new_game()
 