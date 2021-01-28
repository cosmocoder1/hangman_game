require 'yaml'

class Game
 attr_accessor :name 

  def initialize()
   
    @name = ""
    @guesses = []
    @secret_word = ""
    @progress_display = []
    @turn_counter = 10

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
      load_game()
    end 

  end  

  def game_end()
    sleep(5)
    system("clear")
    newGame = Game.new
    newGame.run_new_game()
  end  


  #random word generator and state update
  def generate_word()

    word = File.readlines("dictionary.txt").sample.split('')
    word.pop(2)
  
    if word.length() > 4 && word.length() < 13 
      @secret_word = word 
    else 
      puts 'else block'
      generate_word()
    end  

    puts @secret_word

  end  

  def turn_count()

    if !@progress_display.include?("-")
      puts "Congratulations, you won the game!"
      game_end()
    end

    if @turn_counter == 0
      puts "GAME OVER!  The correct word was #{@secret_word.join('')}"
      game_end()
    else
      @turn_counter -= 1
      puts "You have #{@turn_counter} guesses remaining..."
      make_guess()
    end  
  end  
  

  def update_progress()


    #first guess 
    if !@guesses[0]
      @secret_word.map { |letter| @progress_display.push("-")}
    elsif
      #word guesses
      @guesses[0] && @guesses[@guesses.length() - 1].length() > 1
        if @guesses[@guesses.length() - 1] == @secret_word.join('')
          @progress_display = @guesses[@guesses.length() - 1]
          turn_count()
        end  
    elsif  
    #second guess and beyond  
     @guesses[0] && @secret_word.include?(@guesses[@guesses.length() - 1]) 
      @progress_display.map.with_index { |letter, index| 
        if @guesses[@guesses.length() - 1] == @secret_word[index]
          @progress_display[index] = @secret_word[index]
        end    
      }
      turn_count()

    #incorrect guesses  
    else 
      puts "Sorry, please guess again..."  
      turn_count()
    end

    
  end  

  def make_guess()
    print @progress_display.join('')
    puts ""
    puts ""
    sleep(2)
    puts "Enter a single letter or guess the word..."
    player_guess = gets.chomp

    #handle save
    if player_guess == "save"
      save_game()
      puts "your game has been saved for later..."
    end    

    @guesses.push(player_guess)
    update_progress()
  end  


  def new_game()

    puts "Wonderful!  Type \"save\" at anytime to save the game."
    puts ""
    puts "Choosing a random word now..."
    sleep(2)
    generate_word()
    puts ""
    puts "...done!"
    puts ""
    sleep(1)
    update_progress()
    puts ""
    make_guess()
    
  end 


  def save_game()
    File.open("./saved.yml", 'w') { |f| YAML.dump([] << self, f) }
    exit
    puts "your game has been saved!"
  end

  
  def load_game()
    begin
       yaml = YAML.load_file("../saved.yml")
       @name = yaml[0].name
       @guesses = yaml[0].guesses
       @secret_word = yaml[0].secret_word
       @progress_display = yaml[0].progress_display
       @turn_counter = yaml[0].turn_counter
      rescue
       @name = []
       @guesses = []
       @secret_word = []
       @progress_display = []
       @turn_counter = []

    end
  end  


  def run_new_game()
    get_name()
    intro()
  end  

end  

newGame = Game.new
newGame.run_new_game()
