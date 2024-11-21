class Mastermind
  COLORS = ['R', 'G', 'B', 'Y', 'O', 'P'] # Colors: Red, Green, Blue, Yellow, Orange, Purple
  
  def initialize
    @turns_left = 12
  end

  # Start the game by asking the player if they want to guess or create the code
  def start_game
    puts "Welcome to Mastermind!"
    puts "Would you like to (1) Guess the secret code or (2) Create the secret code?"
    choice = gets.chomp.to_i

    if choice == 1
      guesser_mode
    else
      creator_mode
    end
  end

  private

  # Guesser Mode: The computer generates the code, and the player guesses.
  def guesser_mode
    secret_code = generate_random_code
    puts "I've created a secret code with 4 colors. Try to guess it!"

    # Start the guessing loop
    @turns_left.times do |turn|
      puts "\nTurn #{turn + 1}: You have #{@turns_left - turn} turns left."
      print "Enter your guess (4 colors from #{COLORS.join(', ')}): "
      guess = gets.chomp.upcase.split('')

      if guess.length != 4 || !valid_guess?(guess)
        puts "Invalid guess. Please enter 4 colors from #{COLORS.join(', ')}."
        next
      end

      feedback = get_feedback(secret_code, guess)
      puts "Feedback: #{feedback[:exact]} exact matches, #{feedback[:partial]} partial matches."

      if feedback[:exact] == 4
        puts "Congratulations! You guessed the code correctly!"
        break
      end
    end

    puts "Sorry, you've used all #{@turns_left} turns. The secret code was #{secret_code.join}. Better luck next time!" unless secret_code == guess
  end

  # Creator Mode: The player creates a code, and the computer tries to guess.
  def creator_mode
    puts "Create your secret code! Choose 4 colors from #{COLORS.join(', ')}."
    print "Enter your secret code (4 colors): "
    secret_code = gets.chomp.upcase.split('')
    
    while secret_code.length != 4 || !valid_guess?(secret_code)
      puts "Invalid input. Please enter exactly 4 colors from #{COLORS.join(', ')}."
      print "Enter your secret code (4 colors): "
      secret_code = gets.chomp.upcase.split('')
    end
    
    puts "You created the code! Now, it's my turn to guess!"
    
    computer_guesser(secret_code)
  end

  # The computer will guess and try to find the secret code in creator mode
  def computer_guesser(secret_code)
    possible_codes = generate_all_possible_codes
    @turns_left.times do |turn|
      puts "\nTurn #{turn + 1}: I have #{@turns_left - turn} turns left."
      guess = possible_codes.sample
      puts "My guess: #{guess.join}"

      feedback = get_feedback(secret_code, guess)
      puts "Feedback: #{feedback[:exact]} exact matches, #{feedback[:partial]} partial matches."

      if feedback[:exact] == 4
        puts "I've guessed the secret code correctly! It was #{guess.join}."
        break
      end

      possible_codes = filter_possible_codes(possible_codes, guess, feedback)
    end

    puts "I couldn't guess the code in #{@turns_left} turns. Better luck next time!" unless secret_code == guess
  end

  # Validates a guess to ensure it's 4 colors from the available colors
  def valid_guess?(guess)
    guess.all? { |color| COLORS.include?(color) }
  end

  # Generates a random code (4 colors)
  def generate_random_code
    Array.new(4) { COLORS.sample }
  end

  # Provides feedback on a guess: exact matches (correct color and position),
  # and partial matches (correct color, wrong position)
  def get_feedback(secret_code, guess)
    exact_matches = 0
    partial_matches = 0
    secret_code_copy = secret_code.dup
    guess_copy = guess.dup

    # Check for exact matches
    secret_code.each_with_index do |color, idx|
      if color == guess[idx]
        exact_matches += 1
        secret_code_copy[idx] = nil
        guess_copy[idx] = nil
      end
    end

    # Check for partial matches
    guess_copy.compact.each do |color|
      if secret_code_copy.include?(color)
        partial_matches += 1
        secret_code_copy[secret_code_copy.index(color)] = nil
      end
    end

    { exact: exact_matches, partial: partial_matches }
  end

  # Generates all possible color combinations
  def generate_all_possible_codes
    COLORS.repeated_permutation(4).to_a
  end

  # Filters the list of possible codes based on feedback from a guess
  def filter_possible_codes(possible_codes, guess, feedback)
    possible_codes.select do |code|
      code_feedback = get_feedback(code, guess)
      code_feedback[:exact] == feedback[:exact] && code_feedback[:partial] == feedback[:partial]
    end
  end
end

# Start game
game = Mastermind.new
game.start_game
