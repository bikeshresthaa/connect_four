require_relative '../lib/board'

describe Board do
  let(:board) { described_class.new }
  describe '#initialize' do
    it 'creates a 6 x 7 grid' do
      expect(board.grid.size).to eq(6)
      expect(board.grid.all? { |row| row.size == 7 }).to be true
    end

    it 'creates empty cells' do
      expect(board.grid.flatten.all? { |cell| cell.nil? }).to be true
    end
  end

  describe '#drop_piece' do

    it 'places piece in the specified column' do
      board.drop_piece(1, '🔴')
      expect(board.grid[5][0]).to eq('🔴')
    end

    it 'stacks piece in the given column' do
      board.drop_piece(1, '🔴')
      board.drop_piece(1, '🟡')
      expect(board.grid[5][0]).to eq('🔴')
      expect(board.grid[4][0]).to eq('🟡')
    end

    it 'raises error for invalid column' do
      expect{ board.drop_piece(0, '🟡') }.to raise_error(ArgumentError)
      expect{ board.drop_piece(8, '🟡') }.to raise_error(ArgumentError)
    end

    it 'raises error when column is full' do
      6.times { board.drop_piece(1, '🟡') }
      expect{ board.drop_piece(1, '🟡') }.to raise_error(ArgumentError)
    end
  end

  describe '#full?' do
    it 'returns false for empty board' do
      expect(board.full?).to be false
    end

    it 'returns ture for full board' do
      7.times do |column|
        6.times { board.drop_piece(column + 1, '🟡') }
      end
      expect(board.full?).to be true
    end
  end

  describe '#winner?' do
    it 'detects horizontal win' do
      4.times { |pos| board.drop_piece(pos + 1, '🟡') }
      expect(board.winner?('🟡')).to be true
    end

    it 'detects vertical win' do
      4.times { board.drop_piece(1, '🟡') }
      expect(board.winner?('🟡')).to be true
    end

    xit 'detects diagonal win' do
      board.drop_piece(1, '🟡')
      board.drop_piece(2, '🔴'); board.drop_piece(2, '🟡');
      board.drop_piece(3, '🔴'); board.drop_piece(3, '🔴'); board.drop_piece(3, '🟡');
      board.drop_piece(4, '🔴'); board.drop_piece(4, '🔴'); board.drop_piece(4, '🔴'); board.drop_piece(4, '🟡');
      expect(board.winner?('🟡')).to be true
    end
  end
end