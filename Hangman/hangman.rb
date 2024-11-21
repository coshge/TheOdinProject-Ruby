class Hangman
  def initialize
    # Load saved game if available, otherwise start a new game
    if File.exist?('hangman_save.txt')
      puts "Do you want to load a saved game? (y/n)"
      choice = gets.chomp.downcase
      if choice == 'y'
        load_game
      else
        start_new_game
      end
    else
      start_new_game
    end
  end

  def play
    puts "Welcome to Hangman!"

    # Main game loop
    while @incorrect_guesses < @max_incorrect_guesses
      display
      guess = get_guess

      # After making a guess, provide a save option
      puts "Type 'save' to save the game, or press Enter to continue."

      # Read the input and decide if it's a save command or just continue
      save_choice = gets.chomp.downcase
      if save_choice == 'save'
        save_game
        puts "Game saved!"
        break  # Optionally, break out after saving, or just continue playing
      end

      if @guesses.include?(guess)
        puts "You've already guessed that letter."
      elsif @word.include?(guess)
        puts "Good guess!"
        @guesses << guess
      else
        puts "Incorrect guess!"
        @incorrect_guesses += 1
        @guesses << guess
      end

      # Save the game state after each guess (optional)
      save_game

      if won?
        puts "Congratulations! You've guessed the word: #{@word}."
        break
      end
    end

    if lost?
      puts "Game Over! The word was: #{@word}."
    end
  end

  # Private Methods
  #########################################################
  private

  # Create new game with new word
  def start_new_game
    @words = File.read('google-10000-english-no-swears.txt')
    @word = @words.split(/\s+/).select { |word| word.length.between?(5, 12) }.sample
    @guesses = []
    @incorrect_guesses = 0
    @max_incorrect_guesses = 6
  end

  # Load game state from txt file
  def load_game
    saved_data = File.read('hangman_save.txt').split("\n")
    @word = saved_data[0]
    @guesses = saved_data[1].split(',')
    @incorrect_guesses = saved_data[2].to_i
    @max_incorrect_guesses = saved_data[3].to_i
  end

  # Save game state in txt file
  def save_game
    File.open('hangman_save.txt', 'w') do |file|
      file.puts(@word)                        # Save the word
      file.puts(@guesses.join(','))            # Save guesses as a comma-separated string
      file.puts(@incorrect_guesses)           # Save incorrect guesses count
      file.puts(@max_incorrect_guesses)       # Save max incorrect guesses
    end
  end

  # Display word with known and unknown letters
  def display
    word_display = @word.chars.map { |char| @guesses.include?(char) ? char : '_' }.join(' ')
    puts "Word: #{word_display}"
    puts "Incorrect guesses left: #{@max_incorrect_guesses - @incorrect_guesses}"
  end

  # Get and format guess letter from user
  def get_guess
    print "Enter a letter: "
    guess = gets.chomp.downcase
    until guess.match?(/[a-z]/) && guess.length == 1
      print "Please enter a valid letter: "
      guess = gets.chomp.downcase
    end
    guess
  end

  def won?
    (@word.chars - @guesses).empty?
  end

  def lost?
    @incorrect_guesses >= @max_incorrect_guesses
  end
end

# Start the game
game = Hangman.new
game.play
