require 'yaml'

class Game
 attr_accessor :name, :guesses, :secret_word, :progress_display, :turn_counter

  def initialize
   
    @name = ""
    @guesses = []
    @secret_word = ""
    @progress_display = []
    @turn_counter = 10

  end
  
  def get_name

    puts "Enter your name to begin..."
    @name = gets.chomp
    
  end

  def intro
    puts "Welcome to Hangman, #{@name}!"
    sleep(2)
    puts "Will you be..."
    sleep(1)
    puts "(1) Starting a new game..."
    puts "...or (2) continuing a saved game?"
    game_type = gets.chomp

    if game_type == "1"
      new_game 
    else
      load_game
      run_saved_game
    end 
  end  

  def game_end
    sleep(5)
    system("clear")
    newGame = Game.new
    newGame.run_new_game
  end  

  #random word generator and state update
  def generate_word
    word = File.readlines("dictionary.txt").sample.split('')
    word.pop(2)
      @secret_word = word 
  end  

  def turn_count
    if !@progress_display.include?("-")
      puts "Congratulations, you won the game!"
      game_end
    end

    if @turn_counter == 0
      puts "GAME OVER!  The correct word was #{@secret_word.join('')}"
      game_end

    else
      @turn_counter -= 1
      puts "You have #{@turn_counter} guesses remaining..."
      make_guess
    end  
  end  
  
  def update_progress

    #first guess 
    if !@guesses[0]
      @secret_word.map { |letter| @progress_display.push("-")}
    elsif
      #word guesses
      @guesses[0] && @guesses[@guesses.length() - 1].length() > 1
        if @guesses[@guesses.length() - 1] == @secret_word.join('')
          @progress_display = @guesses[@guesses.length() - 1]
          turn_count
        end  
    elsif  
    #second guess and beyond  
     @guesses[0] && @secret_word.include?(@guesses[@guesses.length() - 1]) 
      @progress_display.map.with_index { |letter, index| 
        if @guesses[@guesses.length() - 1] == @secret_word[index]
          @progress_display[index] = @secret_word[index]
        end    
      }
      turn_count

    #incorrect guesses  
    else 
      puts "Sorry, please guess again..."  
      turn_count
    end

  end  

  def make_guess
    print @progress_display.join('')
    puts ""
    puts ""
    sleep(1)
    puts "Enter a single letter or guess the word..."
    player_guess = gets.chomp

    #handle save
    if player_guess == "save"
      save_game
      puts "your game has been saved for later..."
      game_end
    end    
      @guesses.push(player_guess)
      update_progress
  end  

  def new_game
    puts "Wonderful!  Type \"save\" at anytime to save the game."
    puts ""
    puts "Choosing a random word now..."
    sleep(2)
    generate_word
    puts ""
    puts "...done!"
    puts ""
    sleep(1)
    update_progress
    puts ""
    make_guess
  end 

  def save_game
    puts "enter a name so you can find your game later on..."
    game_name = gets.chomp
    File.open("./saved_games/#{game_name}.yml", 'w') { |f| YAML.dump([] << self, f) }
  end

  def load_game()
      games_list = Dir.entries("./saved_games")
      games_list.shift(2)
      trimmed_list = games_list.map { |title| title_arr = title.split('')
      title_arr.pop(4)
      title_arr.join('') 
      }
      puts trimmed_list
      puts "please enter the name of the game you want to load"
      game_name = gets.chomp

      if !trimmed_list.include?(game_name)
        puts "invalid file name, please enter a file from above"
        sleep(1)
        load_game
      end    
       
      yaml = YAML.load_file("./saved_games/#{game_name}.yml")
      @name = yaml[0].name
      @guesses = yaml[0].guesses
      @secret_word = yaml[0].secret_word
      @progress_display = yaml[0].progress_display
      @turn_counter = yaml[0].turn_counter
      
  end  

  def run_new_game
    get_name
    intro
  end 
  
  def run_saved_game
    puts "welcome back, #{@name}"
    update_progress
    make_guess
  end  

end  

newGame = Game.new
newGame.run_new_game




