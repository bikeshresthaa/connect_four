require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  let(:player1) { Player.new('Ram', '🟡') }
  let(:player2) { Player.new('Shyam', '🔴') }
  let(:game) { described_class.new(player1, player2) }

  describe '#initialize' do
    it 'initializes two players and sets current player' do
      expect(game.players).to eq([player1, player2])
      expect(game.current_player).to eq(player1)
    end
  end

  describe '#switch_player' do
    it 'switches current player' do
      expect(game.current_player).to eq(player1)
      game.switch_player
      expect(game.current_player).to eq(player2)
      game.switch_player
      expect(game.current_player).to eq(player1)
    end
  end

  describe '#play_turn' do
    it 'makes move and switches current player' do
      allow(game).to receive(:gets).and_return("1\n")
      game.play_turn
      expect(game.board.grid[5][0]).to eq('🟡')
      expect(game.current_player).to eq(player2)
    end
  end

  describe '#game_over?' do
    it 'returns false for new game' do
      expect(game.game_over?).to be_falsey
    end

    it 'returns true when a player wins' do
      4.times { |col| game.board.drop_piece(col + 1, '🟡') }
      expect(game.game_over?).to be_truthy
    end

    it 'returns ture when board is full' do
      game.board.grid.each_with_index do |row, row_index|
        row.each_index do |col_index|
          piece = (row_index + col_index).even? ? '🟡' : '🔴'
          game.board.grid[row_index][col_index] = piece
        end
      end
      expect(game.game_over?).to be true
    end
  end

end