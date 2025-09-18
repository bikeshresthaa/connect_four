class Board
  attr_accessor :grid

  ROWS = 6
  COLUMNS = 7
  
  def initialize
    @grid = Array.new(ROWS) { Array.new(COLUMNS) }
  end

  def drop_piece(column, piece)
    column -= 1
    validate_column(column)

    row = find_available_row(column)
    @grid[row][column] = piece
  end

  def full?
    @grid.flatten.none?(&:nil?)
  end

  def winner?(piece)
    horizontal_win(piece) || vertical_win(piece)
  end
  
  private
  
  def column_full?(column)
    @grid[0][column] != nil
  end

  def find_available_row(column)
    (ROWS - 1).downto(0) do |row|
      return row if @grid[row][column].nil?
    end
  end

  def validate_column(column)
    raise ArgumentError, 'Invalid column' unless column.between?(0, COLUMNS - 1)
    raise ArgumentError, 'Column is full' if column_full?(column)
  end

  def horizontal_win(piece)
    (0...ROWS).each do |row|
      (0..COLUMNS - 4).each do |column|
        return true if (0..3).all? { |i| @grid[row][column + i] == piece }
      end
    end
    false
  end

  def vertical_win(piece)
    (0...COLUMNS).each do |column|
      (ROWS - 1).downto(ROWS - 3) do |row|
        return true if (0..3).all? { |i| @grid[row - i][column] == piece }
      end
    end
    false
  end

end