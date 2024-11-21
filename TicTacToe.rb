class TicTacToe
  def initialize
    @board = Array.new(3) { Array.new(3, ' ') }
    @current_player = 'X'
  end

  def play
    loop do
      print_board
      player_move
      if winner?
        print_board
        puts "Player #{@current_player} wins!"
        break
      elsif draw?
        print_board
        puts "It's a draw!"
        break
      end
      switch_player
    end
  end

  private

  def print_board
    puts "\n"
    @board.each do |row|
      puts row.join(' | ')
      puts '--------' unless row == @board.last
    end
    puts "\n"
  end

  def player_move
    loop do
      puts "Player #{@current_player}, enter your move (row and column, 0-2):"
      row, col = gets.chomp.split.map(&:to_i)
      if valid_move?(row, col)
        @board[row][col] = @current_player
        break
      else
        puts "Invalid move! Please try again."
      end
    end
  end

  def valid_move?(row, col)
    row.between?(0, 2) && col.between?(0, 2) && @board[row][col] == ' '
  end

  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end

  def winner?
    # Check rows, columns, and diagonals
    3.times do |i|
      return true if @board[i].all? { |cell| cell == @current_player }
      return true if @board.all? { |row| row[i] == @current_player }
    end
    return true if @board[0][0] == @current_player && @board[1][1] == @current_player && @board[2][2] == @current_player
    return true if @board[0][2] == @current_player && @board[1][1] == @current_player && @board[2][0] == @current_player
    false
  end

  def draw?
    @board.flatten.none? { |cell| cell == ' ' }
  end
end

# Start the game
game = TicTacToe.new
game.play