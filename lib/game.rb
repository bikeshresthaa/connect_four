require_relative 'player'
require_relative 'board'

class Game
  attr_reader :players, :board
  attr_accessor :current_player

  def initialize(player1, player2)
    @players = [player1, player2]
    @current_player = player1
    @board = Board.new
  end

  def play
    until game_over?
      display_board
    end
    display_result
  end

  def switch_player
    @current_player = (@current_player == players[0]) ? players[1] : players[0]
  end

  def play_turn
    column = get_valid_column
    board.drop_piece(column, @current_player.piece)
    switch_player
  end

  def game_over?
    @board.full? || winner
  end

  def winner
    players.each do |player|
      return player if board.winner?(player.piece)
    end
    nil
  end

  private

  def display_board
    puts "\n 1 2 3 4 5 6 7"
    @board.grid.each do |row|
      print "|"
      row.each do |col|
        print col.nil? ? " " : col
        print "|"
      end
      puts
    end
    puts "-------------"
  end

  def display_result
    display_board
    if winner
      puts "#{winner.name} won!!"
    else
      puts "It's a Draw!"
    end
  end

  def get_valid_column
    loop do
      puts "#{@current_player.name}! Enter the desired column(1-7) : "
      column = gets.chomp.to_i
      return column if valid_column?(column)
      puts "Please enter a valid column. (1-6)!"
    end
  end

  def valid_column?(column)
    column.between?(1, Board::COLUMNS) && !board.column_full?(column)
  end
end